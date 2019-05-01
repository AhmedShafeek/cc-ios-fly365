//
//  CheckBoxView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CheckBoxView: UIView {
    
    override func awakeFromNib() {
//        self.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.labelAction)))
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: MyButton!
    
    @IBInspectable var labelText : String = "" {
        didSet {
            label.text = labelText.localized()
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
        let nib = UINib(nibName: CheckBoxView.stringRepresentation, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @objc func labelAction(sender:UITapGestureRecognizer) {
        self.button.isChecked = !self.button.isChecked
    }
}
