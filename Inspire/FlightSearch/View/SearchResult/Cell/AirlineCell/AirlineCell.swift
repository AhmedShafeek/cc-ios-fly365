//
//  AirlineCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class AirlineCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var onlyLabel: MyLabel!
    @IBOutlet weak var airlineCheckBox: CheckBoxView!
    @IBOutlet weak var airlineSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.airlineSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell(airline : Airline) {
        self.airlineCheckBox.labelText = airline.name
        self.airlineSwitch.isHidden = (airline.id == "0")
        self.onlyLabel.isHidden = (airline.id == "0")
        self.airlineSwitch.isOn = airline.only
        self.airlineCheckBox.button.isChecked = airline.checked
        
        if airline.dimmed {
            self.airlineCheckBox.isUserInteractionEnabled = false
            self.airlineSwitch.isUserInteractionEnabled = false
            self.airlineCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.airlineCheckBox.button.imageView!.tintColor = .gray
        }
        else if airline.enable {
            self.airlineCheckBox.isUserInteractionEnabled = true
            self.airlineSwitch.isUserInteractionEnabled = true
            self.airlineCheckBox.label.textColor = .black
            self.onlyLabel.textColor = .black
            self.airlineCheckBox.button.imageView!.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.airlineCheckBox.isUserInteractionEnabled = false
            self.airlineSwitch.isUserInteractionEnabled = false
            self.airlineCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.airlineCheckBox.button.imageView!.tintColor = .gray
        }
    }
}
