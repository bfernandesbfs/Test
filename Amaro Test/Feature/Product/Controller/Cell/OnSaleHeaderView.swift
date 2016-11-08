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
    
    // Var
    fileprivate var collectionViewFlowLayout: CollectionViewFlowLayout!
    // Timer to animation header view
    fileprivate var timer:Timer!
    
    public weak var delegate: OnSaleHeaderViewDelegate?
    
    public var list: [ProductData]! {
        didSet{
            render()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    public override func prepareForReuse() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
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
        if list.count > 0 {
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        }
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedItemOfCollection(data: list[indexPath.row])
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
    
    // Next item and reset
    public func scrollToNext() {
        let indexPath: IndexPath

        if pageView.currentPage == list.count - 1 {
            indexPath = IndexPath(item: 0, section: 0)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.alpha = 0.0
            }, completion: { (finished:Bool) in
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                UIView.animate(withDuration: 0.3, animations: {
                    self.collectionView.alpha = 1.0
                })
            })
            
        }
        else {
            indexPath = IndexPath(item: pageView.currentPage + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        pageView.currentPage = indexPath.row
    }
}
