//
//  ProductViewCell.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class ProductViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelInstallments: UILabel!
    @IBOutlet weak var labelSizes: UILabel!
    @IBOutlet weak var labelSale: UILabel!
    
    public var data: ProductData! {
        didSet{
            render()
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

extension ProductViewCell: ConfigurableUI {
    
    public func configureUI() {
        applyShadow()
        containerView.applyCornerRadius(4)
        applyCornerRadius(4)
        
        labelSale.transform =  CGAffineTransform(rotationAngle: CGFloat.radians(degrees: -45))
    }
    
    public func render() {
        
        labelProductName.text = data.name
        labelPrice.text = data.price
        labelInstallments.text = data.installments
        labelSizes.text = data.sizes
        
        if data.onSale {
            labelSale.isHidden = false
            labelSale.text = data.discount
        }
        else {
            labelSale.isHidden = true
        }
        
        if !data.url.isEmpty {
            if data.image != nil {
                imageProduct.image = data.image
            }
            else {
                imageProduct.imageFromURL(url: data.url, placeholderImage: nil, animate: true) {
                    self.data.image = self.imageProduct.image!
                }
            }
        }
        else {
            imageProduct.image = nil
        }
    }
}
