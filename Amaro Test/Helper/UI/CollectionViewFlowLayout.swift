//
//  CollectionViewFlowLayout.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

// Flow Layout to header View
public class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override public func prepare() {
        super.prepare()
        
        scrollDirection = basedOnScreen()
        
        var width: CGFloat =  0.0
        if scrollDirection == .horizontal {
            width = collectionView!.frame.width
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        }
        else {
            width = collectionView!.frame.width
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView!.decelerationRate = UIScrollViewDecelerationRateNormal
        }
        
        itemSize = CGSize(width: width, height: 200.0)
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let cv = self.collectionView, scrollDirection == .horizontal {
            
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    if let candAttrs = candidateAttributes {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes
                        }
                    }
                    else { // == First time in the loop == //
                        candidateAttributes = attributes
                        continue
                    }
                }
                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y)
            }
        }
        // Fallback
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
    
    private func basedOnScreen() -> UICollectionViewScrollDirection {
        // landscape
        let horizontalSizeClass = self.collectionView?.traitCollection.horizontalSizeClass
        let verticalSizeClass = self.collectionView?.traitCollection.verticalSizeClass
        
        if horizontalSizeClass == UIUserInterfaceSizeClass.regular && verticalSizeClass == UIUserInterfaceSizeClass.regular {
            return .vertical
        }
        else {
            return .horizontal
        }
    }
}
