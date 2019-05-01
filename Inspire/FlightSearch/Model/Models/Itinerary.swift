//
//  Itinerary.swift
//  Fly365
//
//  Created by Ahmed Shafeek on 5/1/19.
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Itinerary : Mappable {
    
    var itineraryId : String!
    var airPriceGroup : Int!
    var connections : [Connection]!
    var legs : [String]!
    var legsOBJ : [Leg] = []
    var pricing : Price!
    var displayPricing : Price!
    var carrier : Carrier!
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public func mapping(map: Map) {
        itineraryId <- map["itineraryId"]
        airPriceGroup <- map["airPriceGroup"]
        connections <- map["connections"]
        legs <- map["legs"]
        pricing <- map["pricing"]
        displayPricing <- map["displayPricing"]
        carrier <- map["carrier"]
    }
}

class ItineraryFilter {
    
    var price : Double!
    var airlines : [Airline]!
    var aircrafts : [Aircraft]!
    var stops : [Stops]!
    
    public init() { }
}
