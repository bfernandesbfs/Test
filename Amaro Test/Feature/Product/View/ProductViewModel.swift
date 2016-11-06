//
//  ProductViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class ProductViewModel: ProductViewProtocol {
    
    private var items: [ProductData]
    private let delegate: ControllerDelegate?
    private let service: ProductService
    
    public required init(target: ControllerDelegate) {
        delegate = target
        items = []
        service = ProductService.shared
    }
    
    public func load(sale: Bool?) {
        
        items = service.list(onSale: sale) { (message) in
                    self.delegate?.didFail(message: message)
            }.map { self.itemOf(product: $0) }
        delegate?.didUpdate()
    }
    
    public func loadHeader() -> [ProductData] {
        return Array(items.filter { $0.onSale }[1..<4])
    }
    
    public func count() -> Int {
        return items.count
    }
    
    public func row(at index: Int) -> ProductData {
        return items[index]
    }
    
    private func itemOf(product: Product) -> ProductData {
        let sizes = "Sizes " + product.sizes.map { $0.size }.joined(separator: " | ")
        return ProductData(image: product.image, name: product.name, price: product.actualPrice, installments: product.installments, sizes: sizes, onSale: product.onSale)
    }
}
