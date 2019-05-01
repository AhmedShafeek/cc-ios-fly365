//
//  Flights.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightResult : Mappable {
    
    var searchId : String!
    var hash : String!
    var itineraries : [Itinerary]!
    var legs : [Leg]!
    var segments : [Segment]!
    var airports : [Airport]!
    var searchParams : FlightSearchDto!
    var meta : Meta!
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public func mapping(map: Map) {
        searchId <- map["searchId"]
        hash <- map["hash"]
        itineraries <- map["itineraries"]
        legs <- map["legs"]
        segments <- map["segments"]
        airports <- map["airports"]
        searchParams <- map["searchParams"]
        meta <- map["meta"]
    }
}

class Meta : Mappable {
    
    var storeId : String!
    var groupId : String!
    var locale : String!
    var currency : String!
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public func mapping(map: Map) {
        storeId <- map["storeId"]
        groupId <- map["groupId"]
        locale <- map["locale"]
        currency <- map["currency"]
    }
}
