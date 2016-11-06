//
//  ControllerDelegate.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

public protocol ControllerDelegate: class {
    func didUpdate()
    func didFail(message: String)
}
