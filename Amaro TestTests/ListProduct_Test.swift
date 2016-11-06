//
//  ListProduct_Test.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import XCTest
@testable import Amaro_Test

class ListProduct_Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListProduct() {
        
        let list = ProductService.shared.list { (message) in
            print(message)
            XCTAssertTrue(message.isEmpty, "Error Parse disk")
        }
        
        XCTAssertTrue(list.count == 22, "It's quantity not compatible")
    }
    
    func testListProductOnSale() {
        
        let list = ProductService.shared.list(onSale: true)
        XCTAssertTrue(list.count == 8, "It's quantity not compatible")
    }
    
    func testProductIntegrity() {
        
        let product = ProductService.shared.list()[15]
    
        XCTAssertTrue(product.name == "BLUSA LAÇO ISTAMBUL", "It's name not compatible")
        XCTAssertTrue(product.color == "LARANJA QUEIMADO", "It's color not compatible")
        XCTAssertTrue(product.sizes.count == 5, "It's quantity of sizes not compatible")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
