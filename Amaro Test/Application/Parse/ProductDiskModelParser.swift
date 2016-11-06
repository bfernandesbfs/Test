//
//  ProductDiskModelParser.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

private struct JSONKeys {
    static let name = "name"
    static let style = "style"
    static let codeColor = "code_color"
    static let colorSlug = "color_slug"
    static let color = "color"
    static let onSale = "on_sale"
    static let regularPrice = "regular_price"
    static let actualPrice = "actual_price"
    static let discountPercentage = "discount_percentage"
    static let installments = "installments"
    static let image = "image"
    static let sizes = "sizes"
}

public struct ProductDiskModelParser: Parseable {
    
    public func parse(_ element: [String: Any]) -> Product {
        
        let name = element[JSONKeys.name] as! String
        let style = element[JSONKeys.style] as! String
        let codeColor = element[JSONKeys.codeColor] as! String
        let colorSlug = element[JSONKeys.colorSlug] as! String
        let color = element[JSONKeys.color] as! String
        let onSale = element[JSONKeys.onSale] as! Bool
        let regularPrice = element[JSONKeys.regularPrice] as! String
        
        let actualPrice = element[JSONKeys.actualPrice] as! String
        let discountPercentage = element[JSONKeys.discountPercentage] as! String
        let installments = element[JSONKeys.installments] as! String
        let image = element[JSONKeys.image] as! String
        let sizes = element[JSONKeys.sizes] as! [[String: Any]]
        
        return Product(name: name, style: style, codeColor: codeColor, colorSlug: colorSlug, color: color, onSale: onSale, regularPrice: regularPrice, actualPrice: actualPrice, discountPercentage: discountPercentage, installments: installments, image: image, sizes: SizesDiskModelParser().parseArray(sizes))
    }
    
}
