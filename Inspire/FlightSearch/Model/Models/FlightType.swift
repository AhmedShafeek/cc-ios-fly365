//
//  FlightType.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation

enum TypeOfFlights: String {
    case oneWay = "one_way"
    case roundTrip = "round_trip"
    case multiCity = "multi_city"
    case buttonView
}

class FlightType {
    
    var type : TypeOfFlights!
    var selected : Bool!
    
    public init(type : TypeOfFlights, selected : Bool) {
        self.type = type
        self.selected = selected
    }
}
