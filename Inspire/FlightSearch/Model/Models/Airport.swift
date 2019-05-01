//
//  Airport.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Airport : Mappable {
    
    var countryName : String!
    var cityCode : String!
    var code : String!
    var name : String!
    var cityName : String!
    var countryCode : String!
    
    required public init?(map: Map) { }
    
    public init() { }
    
    public init(code : String, name : String) {
        self.code = code
        self.name = name
    }
    
    public func mapping(map: Map) {
        countryName <- map["countryName"]
        cityCode <- map["cityCode"]
        code <- map["code"]
        name <- map["name"]
        cityName <- map["cityName"]
        countryCode <- map["countryCode"]
    }
}
