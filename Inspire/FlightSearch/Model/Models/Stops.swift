//
//  Stops.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Stops : Mappable {
    
    var destination : AirportObj!
    var origin : AirportObj!
    var equipment : String!
    
    var noOfStops : Int!
    var name : String!
    var id : String!
    var checked : Bool = true
    var only : Bool = false
    var enable : Bool = true
    var dimmed : Bool = false
    var maxPriceOfItinerary : Double = 0
    
    public init(name : String, id : String, noOfStops : Int, maxPriceOfItinerary : Double) {
        self.name = name
        self.id = id
        self.noOfStops = noOfStops
        self.maxPriceOfItinerary = maxPriceOfItinerary
    }
    
    public init() { }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.destination <- map["destination"]
        self.origin <- map["origin"]
        self.equipment <- map["equipment"]
    }
}
