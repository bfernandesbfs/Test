//
//  UIImageView_Extension.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func imageFromURL(url:String, placeholderImage: UIImage? = nil, animate: Bool = false, onFinish:(() -> Void)?) {
        loadImageFromURL(url: url, placeholderImage: placeholderImage, animate: animate, onFinish: onFinish)
    }
    
    private func loadImageFromURL(url:String, placeholderImage: UIImage? = nil, animate: Bool = false, onFinish:(() -> Void)? = nil) {
        
        ImageRequest.shared.download(url, progress: { (completed, total) in
            //print("Progress: \(Float(completed) / Float(total)) - completed :\(completed) - total:\(total)")
        }) { (response:Response) in
            
            guard let image = response.responseImage else {
                if placeholderImage != nil {
                    DispatchQueue.main.async {
                        self.transitionImageAnimate(newImage: placeholderImage!, animate: animate, onFinish: onFinish)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                self.transitionImageAnimate(newImage: image, animate: animate, onFinish: onFinish)
            }
        }
    }
    
    private func transitionImageAnimate(newImage: UIImage, animate: Bool = false, onFinish:(() -> Void)? = nil) {
        
        if animate {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
            }, completion: { (finished:Bool) in
                self.image = newImage
                onFinish?()
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1.0
                })
            })
        }
        else {
            self.image = newImage
            onFinish?()
        }
    }
}

extension UIImage {
    public func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: size.height)
        context!.scaleBy(x: 1.0, y: -1.0);
        context!.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        context!.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
