//
//  ProductsViewController.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    public var viewModel: ProductViewProtocol!
    fileprivate var isFilter: Bool = false
    fileprivate let screen: UIScreen = UIScreen.main
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProductViewModel(target: self)
        viewModel.load(sale: nil)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        showOption()
    }
    
    // MARK: - Navigation
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController, let index = sender as? Int {
            controller.viewModel = DetailViewModel(at: index)
        }
    }
    
    // Create Action sheet to select an filter
    private func showOption() {
        let alertController = UIAlertController(title: String.localized(id: "label.Search.title"), message: String.localized(id: "label.Search.message"), preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: String.localized(id: "label.Search.cancel"),style: .cancel, handler: nil)
        
        let onSale = UIAlertAction(title: String.localized(id: "label.Search.withDiscount"), style: .default) { (action:UIAlertAction!) in
            self.isFilter = true
            self.viewModel.load(sale: true)
        }
        let noSale = UIAlertAction(title: String.localized(id: "label.Search.withoutDiscount"), style: .default) { (action:UIAlertAction!) in
            self.isFilter = true
            self.viewModel.load(sale: false)
        }
        
        let allSale = UIAlertAction(title: String.localized(id: "label.Search.allProduct"), style: .default) { (action:UIAlertAction!) in
            self.isFilter = false
            self.viewModel.load(sale: nil)
        }
        
        alertController.addAction(onSale)
        alertController.addAction(noSale)
        alertController.addAction(allSale)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}

extension ProductsViewController: ControllerDelegate {
    // Delegate Controller to update
    public func didUpdate() {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeForwards
        transition.duration = 0.3
        
        transition.isRemovedOnCompletion = false
        collectionView.layer.add(transition, forKey: "transitionFade")
        collectionView.reloadData()
    }
    
    public func didFail(message: String) {
        let alertController = UIAlertController(title: String.localized(id: "label.alert.info"), message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: String.localized(id: "label.alert.Ok"),style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OnSaleHeaderViewDelegate {
    
    // CollectionView delegate and datasource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.data = viewModel.row(at: indexPath.row)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return isFilter ? .zero : CGSize(width: collectionView.frame.width, height: 240.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin:CGFloat = 4.0
        let numberOfColumns = 2
        let size = screen.screnSize(byAddingMargins: margin)
        
        let itemWidth = (size - margin) / CGFloat(numberOfColumns)
        
        return CGSize(width: itemWidth - CGFloat(margin), height: 250.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: OnSaleHeaderView = collectionView.dequeueReusableSupplementaryView(elementKind: kind, indexPath: indexPath)
        headerView.delegate = self
        headerView.list = viewModel.loadHeader()
        return headerView
    }
    
    // Listen of cell on header view
    public func didSelectedItemOfCollection(data: ProductData) {
        performSegue(withIdentifier: "segueDetail", sender: viewModel.selectedHeader(product: data))
    }
}
