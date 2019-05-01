//
//  MyCollectionView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

class MyCollectionView: UICollectionView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.registerNib(FlightTypesCell.stringRepresentation)
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.init(hexString: AppConstants.Colors.primaryColor) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor = color
        }
    }
}
