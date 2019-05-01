//
//  LabelTextField.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class LabelTextField: UIView, UITextFieldDelegate {

    private var __maxLengths = [UITextField: Int]()
    @IBOutlet weak var bgView: MyView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable var mandatoryField : Bool = true {
        didSet {
            starLabel.isHidden = !mandatoryField
        }
    }
    
    @IBInspectable var keyboardType : UIKeyboardType = UIKeyboardType.default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    @IBInspectable var titleText : String = "" {
        didSet {
            label.text = titleText
        }
    }
    
    @IBInspectable var minLength : Int = 1 {
        didSet {
            
        }
    }
    
    @IBInspectable var textFieldHint : String = "" {
        didSet {
            textField.placeholder = textFieldHint
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
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if mandatoryField && (textField.text?.count)! < minLength {
            self.bgView.borderColor = UIColor.red
        }
        else {
            self.bgView.borderColor = UIColor(hexString: AppConstants.Colors.grayColor)
        }
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: LabelTextField.stringRepresentation, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
