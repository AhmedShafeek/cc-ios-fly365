//
//  Price.swift
//  Fly365
//
//  Created by Ahmed Shafeek on 5/1/19.
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Price : Mappable {
    
    var base : Double!
    var tax : Double!
    var total : Double!
    var currencyCode : String!
    var segmentIndex : Int!
    var perPassenger : PassengerTypePrice!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.base <- map["base"]
        self.tax <- map["tax"]
        self.total <- map["total"]
        self.currencyCode <- map["currencyCode"]
        self.segmentIndex <- map["segmentIndex"]
    }
}

class PassengerTypePrice : Mappable {
    
    var ADT : PassengerPrice!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.ADT <- map["ADT"]
    }
}

class PassengerPrice : Mappable {
    
    var code : String!
    var count : Int!
    var base : Double!
    var tax : Double!
    var total : Double!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.count <- map["count"]
        self.base <- map["base"]
        self.tax <- map["tax"]
        self.total <- map["total"]
    }
}

