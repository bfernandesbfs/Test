//
//  CartViewProtocol.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Protocol View Model to Cart Controller
public protocol CartViewProtocol {
    
    var subTotal: Double  { get set }
    
    init(target: ControllerDelegate)
    
    func load()
    func count() -> Int
    func row(at index: Int) -> CartData
    func change(at index: Int, quantity: Int)
    func remove(at index: Int)
}
