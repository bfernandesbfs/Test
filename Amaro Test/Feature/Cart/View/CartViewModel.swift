//
//  CartViewModel.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/7/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public class CartViewModel: CartViewProtocol {
    
    //Var
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
    // Load Data
    public func load() {
        items = service.listCart().map { self.itemOf(cart: $0) }
        updateSubTotal()
        delegate?.didUpdate()
    }
    // Number of data on List
    public func count() -> Int {
        return items.count
    }
    // Item of list
    public func row(at index: Int) -> CartData {
        return items[index]
    }
    // Updade quantity of cart
    public func change(at index: Int, quantity: Int) {
        service.addCart(at: index, quantity: quantity, isChange: true)
    
        items[index].changeQuantity(value: quantity)
        updateSubTotal()
    }
    // Remove item of Cart
    public func remove(at index: Int) {
        service.removeCart(at: index)
        items = service.listCart().map { self.itemOf(cart: $0) }
        updateSubTotal()
    }
    // Parse Model Cart to CartData
    private func itemOf(cart: Cart) -> CartData {
        
        let unitPrice = cart.product.actualPrice.replacingOccurrences(of: "R$", with: "")
                                            .replacingOccurrences(of: ",", with: ".")
                                            .trimmingCharacters(in: .whitespaces)
        
        return CartData(url: cart.product.image, name: cart.product.name, color: cart.product.color, unitPrice: Double(unitPrice)!, price: Double(unitPrice)! * Double(cart.quantity), quantity: cart.quantity)
    }
    
    // Update Sub Total
    private func updateSubTotal() {
        subTotal = items.map { $0.price }.reduce(0, +)
    }
}
