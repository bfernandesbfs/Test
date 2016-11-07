//
//  Util.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

extension CGFloat {
    public static func radians(degrees: Double) -> CGFloat {
        return CGFloat(M_PI * (degrees) / 180.0)
    }
}

public extension UIFont {
    
    public func widthOfString (_ string: String, constrainedToHeigth height: CGFloat) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSFontAttributeName: self],
                                                     context: nil).size
    }
}
