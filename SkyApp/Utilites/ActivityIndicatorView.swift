//
//  ActivityIndicatorView.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation
import UIKit

public class ActivityIndicatorView: UIView {
    
    public init() {
        super.init(frame: CGRect.zero)
        
        // View configurations
        self.backgroundColor = UIColor.clear
        
        // Background view configurations
        let bgView = UIView()
        bgView.backgroundColor = UIColor.gray
        bgView.alpha = 0.7
        bgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bgView)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: .alignAllCenterY, metrics: nil, views: ["bg": bgView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bg]|", options: .alignAllCenterX, metrics: nil, views: ["bg": bgView]))
        
        // Activity indicator configurations
        let containerView = UIView()
        containerView.backgroundColor = UIColor.darkGray
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        // Activity indicator configurations
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(ai)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[ai]-20-|", options: .alignAllCenterY, metrics: nil, views: ["ai": ai]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[ai]-20-|", options: .alignAllCenterX, metrics: nil, views: ["ai": ai]))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

