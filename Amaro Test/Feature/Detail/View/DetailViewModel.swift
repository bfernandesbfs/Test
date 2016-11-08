//
//  DetailViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class DetailViewModel: DetailViewProtocol {
    
    // Var
    public var image: String
    public var name: String
    public var color: String
    public var regularPrice: String
    public var actualPrice: String
    public var installments: String
    public var discount: String
    public var onSale: Bool
    public var onCart: Bool
    public var sizes: [String]
    
    public var didChange: ((DetailViewProtocol) -> ())?
    
    private let service: ProductService
    private let index:Int
    
    public required init(at index: Int) {
        self.index = index
        service = ProductService.shared
        image = ""
        name = ""
        color = ""
        regularPrice = ""
        actualPrice = ""
        installments = ""
        discount = ""
        onSale = false
        onCart = false
        sizes = []
    }
    
    // Load Data
    public func load() {
        if let product = service.get(at: index) {
            image = product.image
            name = product.name
            color = product.color
            regularPrice = product.regularPrice
            actualPrice = product.actualPrice
            installments = product.installments
            discount = product.discountPercentage
            onSale = product.onSale
            sizes = product.sizes.filter{ $0.available }.map { $0.size }
            
            onCart = service.checkCart(product: product)
            didChange?(self)
        }
        
    }
    
    // Add item on Cart
    public func addCart() {
        service.addCart(at: index, quantity: 1)
    }
}
