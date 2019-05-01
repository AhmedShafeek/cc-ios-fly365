//
//  AircraftCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class AircraftCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var onlyLabel: MyLabel!
    @IBOutlet weak var aircraftCheckBox: CheckBoxView!
    @IBOutlet weak var aircraftSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.aircraftSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell(aircraft : Aircraft) {
        self.aircraftCheckBox.labelText = aircraft.name
        self.aircraftSwitch.isHidden = (aircraft.code == "")
        self.onlyLabel.isHidden = (aircraft.code == "")
        self.aircraftSwitch.isOn = aircraft.only
        self.aircraftCheckBox.button.isChecked = aircraft.checked
        
        if aircraft.dimmed {
            self.aircraftCheckBox.isUserInteractionEnabled = false
            self.aircraftSwitch.isUserInteractionEnabled = false
            self.aircraftCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.aircraftCheckBox.button.imageView!.tintColor = .gray
        }
        else if aircraft.enable {
            self.aircraftCheckBox.isUserInteractionEnabled = true
            self.aircraftSwitch.isUserInteractionEnabled = true
            self.aircraftCheckBox.label.textColor = .black
            self.onlyLabel.textColor = .black
            self.aircraftCheckBox.button.imageView!.tintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.aircraftCheckBox.isUserInteractionEnabled = false
            self.aircraftSwitch.isUserInteractionEnabled = false
            self.aircraftCheckBox.label.textColor = .gray
            self.onlyLabel.textColor = .gray
            self.aircraftCheckBox.button.imageView!.tintColor = .gray
        }
    }
}
