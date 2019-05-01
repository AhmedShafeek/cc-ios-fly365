//
//  LabelDropDown.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class LabelDropDown: UIView {

    @IBOutlet weak var textFieldIV: TextFieldImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    override func awakeFromNib() {
        self.textFieldIV.textField.isUserInteractionEnabled = false
        self.textFieldIV.bgView.backgroundColor = backgroundcolor
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.textFieldIV.bgView.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            self.textFieldIV.bgView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var backgroundcolor: UIColor = UIColor.clear {
        didSet {
            self.textFieldIV.bgView.backgroundColor = backgroundcolor
        }
    }
    
    @IBInspectable var imageIcon : UIImage = UIImage() {
        didSet {
            let templateImage = self.imageIcon.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.textFieldIV.imageView.image = templateImage
            self.textFieldIV.imageView.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
    }
    
    @IBInspectable var mandatoryField : Bool = true {
        didSet {
            starLabel.isHidden = !mandatoryField
        }
    }
    
    @IBInspectable var titleText : String = "" {
        didSet {
            label.text = titleText
        }
    }
    
    @IBInspectable var textHint : String = "" {
        didSet {
            textFieldIV.textField.placeholder = textHint
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
        let nib = UINib(nibName: LabelDropDown.stringRepresentation, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
