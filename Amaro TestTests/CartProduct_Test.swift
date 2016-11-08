//
//  CartProduct_Test.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import XCTest
@testable import Amaro_Test

class CartProduct_Test: XCTestCase {
    
    var service: ProductService!
    var products:[Product] = []
    override func setUp() {
        super.setUp()
        service = ProductService.shared
        products = service.list()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddCart() {
        var index = Int(arc4random_uniform(22) + 1)
        service.addCart(at: index, quantity: 10)
        
        index = Int(arc4random_uniform(22) + 1)
        service.addCart(at: index, quantity: 5)
        
        index = Int(arc4random_uniform(22) + 1)
        service.addCart(at: index, quantity: 2)
        
        let cart = service.listCart()
        
        XCTAssertTrue(cart.count == 3, "Item not found")
    }
    
    func testChangeCart() {
        let index = Int(arc4random_uniform(22) + 1)
        service.addCart(at: index, quantity: 10)
        
        XCTAssertTrue(service.listCart().count == 1, "Item not found")
        XCTAssertTrue(service.getCart(at: 0)!.quantity == 10, "It's quantity not compatible")
        
        service.addCart(at: 0, quantity: 5, isChange: true)
        
        XCTAssertTrue(service.getCart(at: 0)!.quantity == 5, "It's quantity not compatible")
    }
    
    func testRemoveCart() {
        let index = Int(arc4random_uniform(22) + 1)
        service.addCart(at: index, quantity: 10)
        
        XCTAssertTrue(service.listCart().count == 1, "Item not found")
        
        service.removeCart(at: 0)
        XCTAssertTrue(service.listCart().count == 0, "Item found")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
