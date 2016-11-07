//
//  UIView_Extension.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

private let defaultShadowColor: UIColor = .black
private let defaultShadowRadius: Float = 4.0
private let defaultShadowOpacity: Float = 0.10
private let defaultCornerRadius: Float = 0

extension UIView {
    
    public func applyShadow(_ shadowColor: UIColor = defaultShadowColor,
                     shadowRadius: Float = defaultShadowRadius,
                     shadowOpacity: Float = defaultShadowOpacity,
                     cornerRadius: Float = defaultCornerRadius)
    {
        let shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: CGFloat(cornerRadius)
            ).cgPath
        
        layer.masksToBounds = false
        layer.shadowPath = shadowPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    public func removeShadow() {
        layer.shadowPath = nil
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0
    }
    
    public func applyCornerRadius(_ cornerRadius: Float = defaultCornerRadius) {
        layer.cornerRadius = CGFloat(cornerRadius)
    }
}

extension UIView {
    
    public static func tagsTo(view: UIView?, texts: [String], fontSize: CGFloat) {
        if let view = view {
            var allConstraints = [NSLayoutConstraint]()
            
            var horizontalConstraintsString = ""
            var labelNames = [String: UILabel]()
            
            var allWidth: CGFloat = 0.0
            let margin:   CGFloat = 4.0
            
            for (index, value) in texts.enumerated() {
                let label = addLabel(value, color: UIColor.black, fontSize: fontSize)
                view.addSubview(label)
                
                let width = label.font.widthOfString(label.text!, constrainedToHeigth: view.frame.height).width + 10
                allWidth += width + margin
                
                let labelName = "label\(index)"
                labelNames[labelName] = label
                
                // add vertical constraints to view
                let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[\(labelName)]-0-|", options: [], metrics: nil, views: labelNames)
                allConstraints.append(contentsOf: verticalConstraints)
                // add view to horizontal
                horizontalConstraintsString += index == (texts.count - 1) ? "[\(labelName)(==\(width))]" : "[\(labelName)(==\(width))]-\(margin)-"
            }
            
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-" + horizontalConstraintsString, options: [], metrics: nil, views: labelNames)
            allConstraints.append(contentsOf: horizontalConstraints)
            
            view.addConstraints(allConstraints)
        }
    }
    
    private static func addLabel(_ text: String, color: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = color
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.layer.cornerRadius  = 2
        label.layer.masksToBounds = true
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
