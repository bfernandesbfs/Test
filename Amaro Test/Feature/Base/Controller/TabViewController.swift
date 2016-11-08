//
//  TabViewController.swift
//  Amaro Test
//
//  Created by Bruno Fernandes on 11/8/16.
//  Copyright © 2016 Bruno Fernandes. All rights reserved.
//

import UIKit

public class TabViewController: UITabBarController {

    private let tabHeight:CGFloat = 45
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame:CGRect  = tabBar.frame
        tabFrame.origin.y    = tabBar.frame.origin.y + (tabBar.frame.height - tabHeight)
        tabFrame.size.height = tabHeight
        tabBar.frame = tabFrame
    }
    
    // Notification center post to update on badgevalue
    public func addBadge(notification: Notification) {
        if let userInfo = notification.userInfo, let isAdded = userInfo["isAdded"] as? Bool {
            let item = tabBar.items![1]
            if let value = item.badgeValue {
                if isAdded {
                    item.badgeValue = "\(Int(value)! + 1)"
                }
                else {
                    let badge = Int(value)! - 1
                    item.badgeValue = badge == 0 ? nil : "\(badge)"
                }
            }
            else {
                item.badgeValue = "1"
            }
        }
    }
    
    // Configure View Controller
    private func configureView() {
        
        for (index, item) in tabBar.items!.enumerated() {
            var insets:UIEdgeInsets = item.imageInsets
            insets.top = 5
            insets.bottom -= 5
            item.tag = index
            item.imageInsets =  insets
            item.image = item.selectedImage!.imageWithColor(color: Color.second).withRenderingMode(.alwaysOriginal)
            item.badgeColor = Color.primary
        }
        tabBar.sizeThatFits(CGSize(width:view.frame.width, height: 38.0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addBadge(notification:)), name: postBadge, object: nil)
    }
    
    
}
