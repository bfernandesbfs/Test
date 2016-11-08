//
//  Util.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

// Post Notificaition key
let postBadge = NSNotification.Name(rawValue: "postBadge")

// Pallet of color
public struct Color {
    static let primary:UIColor = UIColor(red:51/255, green:51/255, blue:51/255, alpha: 1.0)
    static let second:UIColor = UIColor(red:210/255, green:210/255, blue:210/255, alpha: 1.0)
}

// return Float to rotate item 
extension CGFloat {
    public static func radians(degrees: Double) -> CGFloat {
        return CGFloat(M_PI * (degrees) / 180.0)
    }
}

// return String to idion
extension String {
    public static func localized(id:String) -> String!{
        return NSLocalizedString(id, comment: "View on file Localizable.strings")
    }
}
// return Size of a especific Font to tag sizes
public extension UIFont {
    
    public func widthOfString (_ string: String, constrainedToHeigth height: CGFloat) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSFontAttributeName: self],
                                                     context: nil).size
    }
}

extension UIScreen {
    
    func screnSize(byAddingMargins margin: CGFloat) -> CGFloat {
        return bounds.width - margin
    }
    
    /**
     Detect if the current device has wide screen
     */
    func isWideScreen() -> Bool {
        return bounds.height >= 568.0
    }
}
