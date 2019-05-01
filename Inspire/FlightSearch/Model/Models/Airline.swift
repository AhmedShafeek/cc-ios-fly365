//
//  Airline.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Airline : Mappable {
    
    var code : String!
    var name : String!
    var id : String!
    var checked : Bool = true
    var only : Bool = false
    var enable : Bool = true
    var dimmed : Bool = false
    var maxPriceOfItinerary : Double = 0
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public init(name : String, id : String, code : String, maxPriceOfItinerary : Double) {
        self.name = name
        self.id = id
        self.code = code
        self.maxPriceOfItinerary = maxPriceOfItinerary
    }

    public init(name : String, id : String, code : String) {
        self.name = name
        self.id = id
        self.code = code
    }
    
    public func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        id <- map["id"]
        maxPriceOfItinerary <- map["maxPriceOfItinerary"]
    }
}
