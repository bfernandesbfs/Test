//
//  SizesDiskModelParser.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

private struct JSONKeys {
    static let available = "available"
    static let size = "size"
    static let sku = "sku"
}

public struct SizesDiskModelParser: Parseable {
    
    public func parse(_ element: [String: Any]) -> ProductSize {
        
        let available = element[JSONKeys.available] as! Bool
        let size = element[JSONKeys.size] as! String
        let sku  = element[JSONKeys.sku] as! String
        
        return ProductSize(available: available, size: size, sku: sku)
    }
}
