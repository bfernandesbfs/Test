//
//  OnSaleProductViewCell.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class OnSaleProductViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelInstallments: UILabel!
    @IBOutlet weak var labelSizes: UILabel!
    
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

extension OnSaleProductViewCell: ConfigurableUI {
    
    public func configureUI() {

    }
    
    public func render() {
        
        labelProductName.text = data.name
        labelPrice.text = data.price
        labelInstallments.text = data.installments
        //labelSizes.text = data.sizes
        
        if !data.url.isEmpty {
            imageProduct.imageFromURL(url: data.url, placeholderImage: nil, animate: false) {
                
            }
        }
        else {
            imageProduct.image = nil
        }
    }
}
