//
//  ProductViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class ProductViewModel: ProductViewProtocol {
    // Var
    private var items: [ProductData]
    private weak var delegate: ControllerDelegate?
    private let service: ProductService
    
    public required init(target: ControllerDelegate) {
        delegate = target
        items = []
        service = ProductService.shared
    }
    
    // Load Data
    public func load(sale: Bool?) {
        
        items = service.list(onSale: sale) { (message) in
                    self.delegate?.didFail(message: message)
            }.map { self.itemOf(product: $0) }
        delegate?.didUpdate()
    }
    
    // Load dianamic data to header view
    public func loadHeader() -> [ProductData] {
        let itemsOnSale = items.filter { $0.onSale }
        let randow = Int(arc4random_uniform(UInt32(itemsOnSale.count - 3))) + 1
        return Array(items.filter { $0.onSale }[randow..<randow + 3])
    }
    
    // Number of items
    public func count() -> Int {
        return items.count
    }
    
    // Item on list porducts
    public func row(at index: Int) -> ProductData {
        return items[index]
    }
    
    // Selected item on Header list
    public func selectedHeader(product: ProductData) -> Int {
        return items.index(where: { (p) -> Bool in
            return p == product
        })!
    }
    // Parse Product to ProductData
    private func itemOf(product: Product) -> ProductData {
        let sizes = product.sizes.filter{ $0.available }.map { $0.size }.joined(separator: " | ")
        return ProductData(name: product.name, price: product.actualPrice, installments: product.installments, discount: product.discountPercentage ,sizes: sizes, onSale: product.onSale, url: product.image, image: nil)
    }
}
