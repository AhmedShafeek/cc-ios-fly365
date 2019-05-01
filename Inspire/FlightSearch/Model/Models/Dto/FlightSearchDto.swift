
//
//  FlightSearchPost.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightSearchDto : Mappable {
    
    var legs : [Leg] = []
    var adult : Int!
    var child : Int!
    var infant : Int!
    var cabinClass : String!
    
    public init(legs : [Leg], adult : Int, child : Int, infant : Int, cabinClass : String) {
        self.legs = legs
        self.adult = adult
        self.child = child
        self.infant = infant
        self.cabinClass = cabinClass
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.legs <- map["legs"]
        self.adult <- map["adult"]
        self.child <- map["child"]
        self.infant <- map["infant"]
        self.cabinClass <- map["cabinClass"]
    }
}
