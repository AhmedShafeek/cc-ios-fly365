//
//  NoOfStopsCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class NoOfStopsCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var onlyLabel: MyLabel!
    @IBOutlet weak var noOfStopsCheckBox: CheckBoxView!
    @IBOutlet weak var noOfStopsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.noOfStopsSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell(stops : Stops) {
        self.noOfStopsCheckBox.labelText = stops.name
        self.noOfStopsSwitch.isHidden = (stops.id == "0")
        self.onlyLabel.isHidden = (stops.id == "0")
        self.noOfStopsSwitch.isOn = stops.only
        self.noOfStopsCheckBox.button.isChecked = stops.checked
        
        if stops.dimmed {
            self.noOfStopsCheckBox.isUserInteractionEnabled = false
            self.noOfStopsSwitch.isUserInteractionEnabled = false
            self.noOfStopsCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.noOfStopsCheckBox.button.imageView!.tintColor = .gray
        }
        else if stops.enable {
            self.noOfStopsCheckBox.isUserInteractionEnabled = true
            self.noOfStopsSwitch.isUserInteractionEnabled = true
            self.noOfStopsCheckBox.label.textColor = .black
            self.onlyLabel.textColor = .black
            self.noOfStopsCheckBox.button.imageView!.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.noOfStopsCheckBox.isUserInteractionEnabled = false
            self.noOfStopsSwitch.isUserInteractionEnabled = false
            self.noOfStopsCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.noOfStopsCheckBox.button.imageView!.tintColor = .gray
        }
    }
}
