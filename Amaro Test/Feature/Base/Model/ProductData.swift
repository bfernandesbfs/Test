//
//  ProductData.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

// Domain transport data bettween viewModel and ViewController
public struct ProductData: Equatable {
    var name : String
    var price: String
    var installments: String
    var discount: String
    var sizes: String
    var onSale: Bool
    var url: String
    var image: UIImage?
}

public func ==(l:ProductData, r:ProductData) -> Bool {
    return l.name == r.name && l.price == r.price
}
