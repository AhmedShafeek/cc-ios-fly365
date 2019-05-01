//
//  MDCSlider.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSlider

class MyMDCSlider: MDCSlider {

    func setup() {
        self.isStatefulAPIEnabled = true
        self.setThumbColor(UIColor(hexString: AppConstants.Colors.primaryColor), for: .normal)
        self.setTrackFillColor(UIColor(hexString: AppConstants.Colors.primaryColor), for: .normal)
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
