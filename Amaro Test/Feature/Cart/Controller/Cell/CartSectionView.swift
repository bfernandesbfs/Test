//
//  CartSectionView.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class CartSectionView: UIView {

    @IBOutlet weak var labelSubTotal: UILabel!
    
    public var subTotal: Double! {
        didSet {
            self.labelSubTotal.text = String(format: "R$ %.2f", subTotal).replacingOccurrences(of: ".", with: ",")
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    //Load Nib 
    private func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: CartSectionView.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
    }
}
