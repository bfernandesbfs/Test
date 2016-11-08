//
//  Product.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public struct Product: Equatable {
    
    public var name: String
    public var style: String
    public var codeColor: String
    public var colorSlug: String
    public var color: String
    public var onSale: Bool
    public var regularPrice: String
    public var actualPrice: String
    public var discountPercentage: String
    public var installments: String
    public var image: String
    public var sizes: [ProductSize]
}

public func ==(l:Product, r:Product) -> Bool {
    return l.name == r.name && l.style == r.style
}
