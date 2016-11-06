//
//  Response.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public struct Response {
    // Actual fields.
    public let data: Data!
    public let response: URLResponse!
    public var error: Error?
    
    // Helpers.
    public var HTTPResponse: HTTPURLResponse! {
        return response as? HTTPURLResponse
    }
    
    public var statusCode: Int {
        return HTTPResponse.statusCode
    }
    
    public var responseImage: UIImage? {
        if let data = data {
            return UIImage(data: data)
        }
        return nil
    }
}
