//
//  MyTableView.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

class MyTableView: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.registerNib(OneWayCell.stringRepresentation)
        self.registerNib(RoundTripCell.stringRepresentation)
        self.registerNib(MultiCityCell.stringRepresentation)
        self.registerNib(ButtonsCell.stringRepresentation)
        self.registerNib(ItemCell.stringRepresentation)
        self.registerNib(FlightResultCell.stringRepresentation)
        self.registerNib(BoundResultCell.stringRepresentation)
        self.registerNib(LoadingCell.stringRepresentation)
        self.registerNib(AirlineCell.stringRepresentation)
        self.registerNib(AircraftCell.stringRepresentation)
        self.registerNib(NoOfStopsCell.stringRepresentation)
        self.separatorStyle = .none
    }
}
