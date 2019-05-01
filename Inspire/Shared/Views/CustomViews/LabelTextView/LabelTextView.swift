//
//  LabelTextView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class LabelTextView: UIView, UITextViewDelegate {
    
    private var __maxLengths = [UITextField: Int]()
    @IBOutlet weak var bgView: MyView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
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
    
    @IBInspectable var maxLength : Int = 10 {
        didSet {
        }
    }
    
    @IBInspectable var minLength : Int = 1 {
        didSet {
            
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
        self.textView.delegate = self
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < maxLength    // 10 Limit Value
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: LabelTextView.stringRepresentation, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
