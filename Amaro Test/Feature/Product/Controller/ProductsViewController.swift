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
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProductViewModel(target: self)
        viewModel.load(sale: nil)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first {
            controller.viewModel = DetailViewModel(at: indexPath.row)
        }
    }
}

extension ProductsViewController: ControllerDelegate {
    
    public func didUpdate() {
        collectionView.reloadData()
    }
    
    public func didFail(message: String) {
        print(message)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: OnSaleHeaderView = collectionView.dequeueReusableSupplementaryView(elementKind: kind, indexPath: indexPath)
        headerView.list = viewModel.loadHeader()
        return headerView
    }
}
