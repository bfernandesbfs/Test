//
//  UIImageView_Extension.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/6/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func imageFromURL(url:String, placeholderImage: UIImage? = nil, animate: Bool = false) {
        loadImageFromURL(url: url, placeholderImage: placeholderImage, animate: animate)
    }
    
    private func loadImageFromURL(url:String, placeholderImage: UIImage? = nil, animate: Bool = false) {
        
        ImageRequest.shared.download(url, progress: { (completed, total) in
            //print("Progress: \(Float(completed) / Float(total)) - completed :\(completed) - total:\(total)")
        }) { (response:Response) in
            
            guard let image = response.responseImage else {
                if placeholderImage != nil {
                    DispatchQueue.main.async {
                        self.transitionImageAnimate(newImage: placeholderImage!, animate: animate)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                self.transitionImageAnimate(newImage: image, animate: animate)
            }
        }
    }
    
    private func transitionImageAnimate(newImage: UIImage, animate: Bool = false) {
        
        if animate {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
            }, completion: { (finished:Bool) in
                self.image = newImage
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1.0
                })
            })
        }
        else {
            self.image = newImage
        }
    }
}
