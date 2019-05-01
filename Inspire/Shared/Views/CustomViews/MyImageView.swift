//
//  MyImageView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MyImageView: UIImageView {
    
    @IBInspectable var color: UIColor = UIColor(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.image = templateImage
            self.tintColor = color
        }
    }
    
    @IBInspectable var defultColor: Bool = false {
        didSet {
            self.backgroundColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
    }
    
    @IBInspectable var imageCircle: Bool = false {
        didSet {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = self.frame.height/2
            self.clipsToBounds = true
        }
    }
    
    func setup() {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func setImage(image: UIImage) {
        let templateImage = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
