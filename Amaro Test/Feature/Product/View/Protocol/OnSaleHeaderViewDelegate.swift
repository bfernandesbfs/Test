//
//  OnSaleHeaderViewDelegate.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/8/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

// Delete to listen user interation click on cell 
public protocol OnSaleHeaderViewDelegate: class {
    func didSelectedItemOfCollection(data: ProductData)
}
