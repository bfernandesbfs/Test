//
//  Parseable.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

public protocol Parseable {
    associatedtype E
    associatedtype T
    
    func parse(_ element: E) -> T
}

public extension Parseable {
    
    func parseArray(_ elements: [E]) -> [T] {
        return elements.map { element -> T in
            return parse(element)
        }
    }
}
