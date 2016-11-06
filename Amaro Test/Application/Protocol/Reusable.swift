//
//  Reusable.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension Reusable {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static var nib: UINib? {
        let bundle = Bundle(identifier: String(describing: Self.self))
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        return nib
    }
}
