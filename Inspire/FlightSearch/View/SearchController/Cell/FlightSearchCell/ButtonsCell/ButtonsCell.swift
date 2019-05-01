//
//  ButtonsCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class ButtonsCell: UITableViewCell {

    @IBOutlet weak var addTripHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addTripButton: MyButton!
    @IBOutlet weak var searchButton: MyButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(bound: Bounds, index: Int, noOfCells: Int) {
        if bound.type == TypeOfFlights.multiCity && noOfCells < 6 {
            self.addTripHeightConstraint.constant = 39
            self.addTripButton.isHidden = false
        }
        else {
            self.addTripHeightConstraint.constant = 0
            self.addTripButton.isHidden = true
        }
    }
}
