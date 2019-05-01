//
//  Connection.swift
//  Fly365
//
//  Created by Ahmed Shafeek on 5/1/19.
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Connection : Mappable {
    
    var changeOfPlane : Bool!
    var changeOfTerminal : Bool!
    var changeOfAirport : Bool!
    var stopOver : Bool!
    var segmentIndex : Int!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.changeOfPlane <- map["changeOfPlane"]
        self.changeOfTerminal <- map["changeOfTerminal"]
        self.changeOfAirport <- map["changeOfAirport"]
        self.stopOver <- map["stopOver"]
        self.segmentIndex <- map["segmentIndex"]
    }
}
