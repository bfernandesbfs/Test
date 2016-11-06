//
//  OnSaleHeaderView.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class OnSaleHeaderView: UICollectionReusableView, Reusable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    fileprivate var collectionViewFlowLayout: CollectionViewFlowLayout!
    
    public var list: [ProductData]! {
        didSet{
            render()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

extension OnSaleHeaderView: ConfigurableUI {
    
    public func configureUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFlowLayout = collectionView.collectionViewLayout as! CollectionViewFlowLayout
    }
    
    public func render() {
        collectionView.reloadData()
    }
}


extension OnSaleHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OnSaleProductViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.data = list[indexPath.row]
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200.0)
    }
    
    // MARK: - Scroll View Delegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if collectionViewFlowLayout.scrollDirection == .horizontal {
            let floatPage:CGFloat = collectionView.contentOffset.x / frame.width
            let index:Int = Int(floatPage)
            pageView.currentPage = index
        }
    }
}
