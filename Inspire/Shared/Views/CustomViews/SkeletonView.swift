//
//  SkeletonView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

class SkeletonView: UIView {
    
    var startLocations : [NSNumber] = [-1.0,-0.5, 0.0]
    var endLocations : [NSNumber] = [1.0,1.5, 2.0]
    
    var gradientBackgroundColor : CGColor = UIColor(white: 1, alpha: 1.0).cgColor
    var gradientMovingColor : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    
    var movingAnimationDuration : CFTimeInterval = 1
    var delayBetweenAnimationLoops : CFTimeInterval = 1.0
    
    
    lazy var gradientLayer : CAGradientLayer = {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor
        ]
        gradientLayer.locations = self.startLocations
        self.layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    
    func startAnimating(){
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = 5
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    func stopAnimating() {
        self.gradientLayer.removeAllAnimations()
    }
    
}
