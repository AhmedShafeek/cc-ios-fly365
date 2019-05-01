//
//  TextFieldImageView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextFieldImageView: UIView {
        
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: MyImageView!
    @IBOutlet weak var bgView: MyView!
    
    @IBInspectable var labelHint : String = "" {
        didSet {
            textField.placeholder = labelHint.localized()
        }
    }
    
    @IBInspectable var imageIcon : UIImage = UIImage() {
        didSet {
            let templateImage = self.imageIcon.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.imageView.image = templateImage
            self.imageView.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: TextFieldImageView.stringRepresentation, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
