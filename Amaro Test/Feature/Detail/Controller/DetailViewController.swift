//
//  DetailViewController.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelRegularPrice: UILabel!
    @IBOutlet weak var labelActualPrice: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var containerSizes: UIView!
    
    public var viewModel: DetailViewProtocol! {
        didSet {
            getViewModel(v: viewModel)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCartButtonPressed(_ sender: UIButton) {
        viewModel.addCart()
    }
    
    /**
     MARK: - Private Methods
     */
    
    private func getViewModel(v: DetailViewProtocol) {
        var v = v
        v.didChange = { [weak self] view in
            self?.labelProductName.text = view.name
            self?.labelActualPrice.text = view.actualPrice
            self?.labelColor.text = view.color
            
            if view.onSale {
                self?.labelRegularPrice.isHidden = false
                self?.labelRegularPrice.text = view.regularPrice
            }
            else {
                self?.labelRegularPrice.isHidden = true
            }
            
            UIView.tagsTo(view: self?.containerSizes, texts: view.sizes, fontSize: 14.0)
            
            if !view.image.isEmpty {
                self?.imageProduct.imageFromURL(url: view.image, placeholderImage: nil, animate: false) {
                    
                }
            }
            else {
                self?.imageProduct.image = nil
            }
        }
    }
}
