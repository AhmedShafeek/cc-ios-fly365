//
//  FlightTypesCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class FlightTypesCell: UICollectionViewCell {

    @IBOutlet weak var typeLabel: MyLabel!
    @IBOutlet weak var underView: MyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(flightType : FlightType) {
        self.typeLabel.text = flightType.type.rawValue.localized()
        self.underView.isHidden = !flightType.selected
    }
}
