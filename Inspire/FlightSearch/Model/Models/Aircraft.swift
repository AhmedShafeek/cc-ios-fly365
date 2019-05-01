//
//  Aircraft.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Aircraft : Mappable {
    
    var code : String!
    var name : String!
    var checked : Bool = true
    var only : Bool = false
    var enable : Bool = true
    var dimmed : Bool = false
    var maxPriceOfItinerary : Double = 0
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public init(name : String, code : String) {
        self.name = name
        self.code = code
    }
    
    public init(name : String, code : String, maxPriceOfItinerary : Double) {
        self.name = name
        self.code = code
        self.maxPriceOfItinerary = maxPriceOfItinerary
    }
    
    public func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        maxPriceOfItinerary <- map["maxPriceOfItinerary"]
    }
}
