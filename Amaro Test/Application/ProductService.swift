//
//  ProductService.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Product Service
public class ProductService {

    // VAr
    private var products: [Product]
    private var filteredProducts: [Product]
    private var cart : [Cart]

    //Singleton
    public class var shared: ProductService {
        struct Static {
            static let instance = ProductService()
        }
        return Static.instance
    }
    
    private init() {
        products = []
        filteredProducts = []
        cart     = []
    }
    
    /*
     Product Function
     */
    // List and filter Products
    public func list(onSale: Bool? = nil, falid:((_ message: String)-> Void)? = nil) -> [Product] {
        do {
            filteredProducts = try getProductsFromDisk()
            if let onSale = onSale {
                filteredProducts =  filteredProducts.filter { $0.onSale == onSale }
            }
            
            return filteredProducts
        }
        catch {
            falid?("Opss! Error")
        }
        
        return []
    }
    
    // Get product
    public func get(at index: Int) -> Product? {
        if filteredProducts.count == 0 {
            return nil
        }
        return filteredProducts[index]
    }
    
    /*
     Cart Function
     */
    // List all item on Cart
    public func listCart() -> [Cart] {
        return cart
    }
    
    // Check if contains item on cart
    public func checkCart(product: Product) -> Bool {
        return cart.map { $0.product }.contains(product)
    }
    
    // Add item on Cart or change your quantity
    public func addCart(at index: Int, quantity: Int ,isChange: Bool = false) {
        if !isChange {
            cart.append(Cart(product: filteredProducts[index], quantity: quantity))
        }
        else {
            cart[index].changeQuantity(value: quantity)
        }
    }
    
    // Get item on Cart
    public func getCart(at index: Int) -> Cart? {
        if cart.count == 0 {
            return nil
        }
        return cart[index]
    }
    
    // Remove item of Cart
    public func removeCart(at index: Int) {
        if cart.count > 0 {
            cart.remove(at: index)
        }
    }
    
    // Load Product 
    private func getProductsFromDisk() throws -> [Product] {
        if products.count > 0 {
            return products
        }
    
        if let data:[String:Any] = try Loader.fixture("products"), let list = data["products"] as? [[String:Any]] {
            products = ProductDiskModelParser().parseArray(list)
        }
    
        return products
    }
    
}
