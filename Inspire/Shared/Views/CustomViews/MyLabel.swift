//
//  MyLabel.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MyLabel: UILabel {
    
    @IBInspectable var localizedText: String = "" {
        didSet {
            self.text = localizedText.localized()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            self.textColor = color
        }
    }
    
    func setup() {
        self.textColor = color
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
