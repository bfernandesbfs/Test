//
//  CartViewCell.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class CartViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelUnitPrice: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var buttonDecrement: UIButton!
    @IBOutlet weak var buttonIncrement: UIButton!

    public var didChange: ((_ value: String) -> ())?
    
    fileprivate var stepper: BUIStepper!

    public var data: CartData! {
        didSet{
            render()
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

extension CartViewCell: ConfigurableUI {
    
    public func configureUI() {
        stepper = BUIStepper(decrementButton: buttonDecrement, incrementButton: buttonIncrement)
        stepper.maximumValue = 9999
        stepper.minimumValue = 1
        stepper.value = 1.0
    }
    
    public func render() {
        
        labelProductName.text = data.name
        labelColor.text = data.color
        labelUnitPrice.text = String(format: "R$ %.2f", data.unitPrice).replacingOccurrences(of: ".", with: ",")
        labelPrice.text = String(format: "R$ %.2f", data.price).replacingOccurrences(of: ".", with: ",")
        labelQuantity.text = String(data.quantity)
        
        if !data.url.isEmpty {
            imageProduct.imageFromURL(url: data.url, placeholderImage: nil, animate: false) {
            }
        }
        else {
            imageProduct.image = nil
        }
        
        stepper.valueChangedCallback = { [unowned self] stepper in
            self.labelQuantity.text = String(format: "%.f", stepper.value)
            self.labelPrice.text = String(format: "R$ %.2f", self.data.unitPrice * stepper.value).replacingOccurrences(of: ".", with: ",")
            
            self.didChange?(self.labelQuantity.text!)
        }
    }
}
