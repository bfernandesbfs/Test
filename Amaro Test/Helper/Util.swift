//
//  Util.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public struct Color {
    static let primary:UIColor = UIColor(red:51/255, green:51/255, blue:51/255, alpha: 1.0)
    static let second:UIColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1.0)
}

extension CGFloat {
    public static func radians(degrees: Double) -> CGFloat {
        return CGFloat(M_PI * (degrees) / 180.0)
    }
}

extension String {
    public static func localized(id:String) -> String!{
        return NSLocalizedString(id, comment: "View on file Localizable.strings")
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
