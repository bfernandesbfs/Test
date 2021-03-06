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
    @IBOutlet weak var labelInstallments: UILabel!
    @IBOutlet weak var labelSale: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var containerSizes: UIView!
    @IBOutlet weak var buttonCart: UIButton!
    
    public var viewModel: DetailViewProtocol! {
        didSet {
            getViewModel(v: viewModel)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Action Button to Add item on Cart
    @IBAction func addCartButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            viewModel.addCart()
            let title = String.localized(id: "label.button.alreadyBag")
            self.buttonCart.setTitle(title, for: .normal)
            self.buttonCart.tag = 1
            
            NotificationCenter.default.post(name: postBadge, object: self, userInfo: ["isAdded": true])
        }
    }
    
    /**
     MARK: - Private Methods
     */
    
    // Configure View Controller
    private func configureView() {
        labelSale.transform =  CGAffineTransform(rotationAngle: CGFloat.radians(degrees: -45))
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    // Observer protocol detail
    private func getViewModel(v: DetailViewProtocol) {
        var v = v
        v.didChange = { [weak self] view in
            self?.title = view.name
            self?.labelProductName.text = view.name
            self?.labelActualPrice.text = view.actualPrice
            self?.labelInstallments.text = view.installments
            self?.labelColor.text = view.color
            
            let title = view.onCart ? String.localized(id: "label.button.alreadyBag") : String.localized(id: "label.button.addBag")
            self?.buttonCart.setTitle(title, for: .normal)
            self?.buttonCart.tag = view.onCart.hashValue
            
            if view.onSale {
                self?.labelSale.isHidden = false
                self?.labelRegularPrice.isHidden = false
                
                self?.labelSale.text = view.discount
                self?.labelRegularPrice.text = view.regularPrice
            }
            else {
                self?.labelSale.isHidden = true
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
