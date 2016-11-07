//
//  DetailViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class DetailViewModel: DetailViewProtocol {
    
    public var image: String
    public var name: String
    public var color: String
    public var regularPrice: String
    public var actualPrice: String
    public var installments: String
    public var discount: String
    public var onSale: Bool
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
        sizes = []
    }
    
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
            sizes = product.sizes.map { $0.size }
            
            didChange?(self)
        }
        
    }
    
    public func addCart() {
    
    }
}
