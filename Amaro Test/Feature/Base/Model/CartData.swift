//
//  CartData.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Domain transport data bettween viewModel and ViewController
public struct CartData {
    var url: String
    var name: String
    var color: String
    var unitPrice: Double
    var price: Double
    var quantity: Int
    
    mutating public func changeQuantity(value: Int) {
        quantity = value
        price = unitPrice * Double(value)
    }
}
