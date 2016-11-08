//
//  Loader.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/4/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import Foundation

// Load JSON file 
public class Loader {
    
    static func fixture<T>(_ filePath: String) throws -> T {
        let bundle = Bundle(for:object_getClass(self))
        let jsonFile = bundle.path(forResource: filePath, ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!))
        
        let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments)
        return json as! T
    }
}
