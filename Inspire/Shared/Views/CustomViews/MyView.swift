//
//  UIView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MyView: UIView {
    
    @IBInspectable var color: UIColor = UIColor(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            self.backgroundColor = color
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var radiusBorder: Bool = false {
        didSet {
            self.layoutIfNeeded()
            self.layer.cornerRadius = self.frame.height / 3
            self.layer.masksToBounds = radiusBorder
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layoutIfNeeded()
            self.layer.cornerRadius = radius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = .zero
            layer.shadowRadius = 5
            layer.shouldRasterize = true
            layer.rasterizationScale = shadow ? UIScreen.main.scale : 1
        }
    }
    
    func setup() {
        self.backgroundColor = color
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
