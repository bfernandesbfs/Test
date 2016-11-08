//
//  CartViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class CartViewModel: CartViewProtocol {
    
    public var subTotal: Double
    
    private weak var delegate: ControllerDelegate?
    private var items:[CartData]
    private let service: ProductService
    
    public required init(target: ControllerDelegate) {
        delegate = target
        service = ProductService.shared
        items = []
        subTotal = 0.0
    }
    
    public func load() {
        items = service.listCar().map { self.itemOf(cart: $0) }
        updateSubTotal()
        delegate?.didUpdate()
    }
    
    public func count() -> Int {
        return items.count
    }
    
    public func row(at index: Int) -> CartData {
        return items[index]
    }
    
    public func change(at index: Int, quantity: Int) {
        service.addCart(at: index, quantity: quantity, isChange: true)
    
        items[index].changeQuantity(value: quantity)
        updateSubTotal()
    }
    
    public func remove(at index: Int) {
        service.removeCart(at: index)
        items = service.listCar().map { self.itemOf(cart: $0) }
        updateSubTotal()
    }
    
    private func itemOf(cart: Cart) -> CartData {
        
        let unitPrice = cart.product.actualPrice.replacingOccurrences(of: "R$", with: "")
                                            .replacingOccurrences(of: ",", with: ".")
                                            .trimmingCharacters(in: .whitespaces)
        
        return CartData(url: cart.product.image, name: cart.product.name, color: cart.product.color, unitPrice: Double(unitPrice)!, price: Double(unitPrice)! * Double(cart.quantity), quantity: cart.quantity)
    }
    
    private func updateSubTotal() {
        subTotal = items.map { $0.price }.reduce(0, +)
    }
}
