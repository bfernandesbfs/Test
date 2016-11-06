//
//  Cart.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public struct Cart {
    public var product: Product
    public var quantity: Int
    
    mutating public func changeQuantity(value: Int) {
        quantity = value
    }
}
