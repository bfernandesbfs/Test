//
//  DetailViewProtocol.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Protocol View Model to Detail Controller
public protocol DetailViewProtocol {
    
    var image: String { get set }
    var name: String { get set }
    var color: String { get set }
    var regularPrice: String { get set }
    var actualPrice: String { get set }
    var installments: String { get set }
    var discount: String { get set }
    var onSale: Bool { get set }
    var onCart: Bool { get set }
    var sizes: [String] { get set }
    
    var didChange: ((DetailViewProtocol) -> ())? { get set }
    
    init(at index: Int)
    
    func load()
    func addCart()
}
