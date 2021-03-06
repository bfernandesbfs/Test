//
//  ProductViewProtocol.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Protocol View Model to Product Controller 
public protocol ProductViewProtocol {
    
    init(target: ControllerDelegate)
    
    func load(sale: Bool?)
    func loadHeader() -> [ProductData]
    func selectedHeader(product: ProductData) -> Int
    func count() -> Int
    func row(at index: Int) -> ProductData
}
