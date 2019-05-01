//
//  MyButton.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

class MyButton: UIButton {
    
    let checkedImage = UIImage(named: "check")! as UIImage
    
    // Bool property
    
    @IBInspectable var localizedText: String = "" {
        didSet{
            self.setTitle(localizedText.localized(), for: .normal)
        }
    }
    
    @IBInspectable var checkBox: Bool = false {
        didSet{
            if isChecked == true {
                _ = checkedImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.setImage(checkedImage, for: .normal)
                self.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            } else {
                self.setImage(nil, for: .normal)
            }
        }
    }
    
    // Bool property
    @IBInspectable var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                _ = checkedImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.setImage(checkedImage, for: .normal)
                self.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            } else {
                self.setImage(nil, for: .normal)
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layoutIfNeeded()
            self.layer.cornerRadius = radius
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.init(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            self.setTitleColor(textColor, for: .normal)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.init(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        self.setTitleColor(textColor, for: .normal)
        self.layer.borderColor = borderColor.cgColor
        if checkBox {
            self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        }
    }
    
    @objc func buttonClicked(sender: UIButton) {
        isChecked = !isChecked
    }
    
    @IBInspectable var radiusBorder: Bool = false {
        didSet {
            self.layoutIfNeeded()
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = radiusBorder
        }
    }
    
    @IBInspectable var gradientBackground: Bool = false {
        didSet {
            if gradientBackground {
                backgroundColor = UIColor().colorWithGradient(frame: frame, colors: [UIColor.init(hexString: AppConstants.Colors.secondaryColor), UIColor.init(hexString: AppConstants.Colors.primaryColor)])
            }
        }
    }
}
