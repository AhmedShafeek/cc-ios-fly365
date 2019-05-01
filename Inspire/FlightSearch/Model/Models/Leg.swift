//
//  Legs.swift
//  Fly365
//
//  Created by Ahmed Shafeek on 4/30/19.
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Leg : Mappable {
    
    var legId : String!
    var origin : String!
    var originOBJ : Airport!
    var destination : String!
    var destinationOBJ : Airport!
    var departureDate : String!
    var arrivalDate : String!
    var stops : Int!
    var carrier : Carrier!
    var duration : Int!
    var segments : [String]!
    var segmentsOBJ : [Segment] = []
    
    public init(origin : String, destination : String, departureDate : String) {
        self.origin = origin
        self.destination = destination
        self.departureDate = departureDate
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.legId <- map["legId"]
        self.origin <- map["origin"]
        self.destination <- map["destination"]
        self.departureDate <- map["departureDate"]
        self.arrivalDate <- map["arrivalDate"]
        self.stops <- map["stops"]
        self.carrier <- map["carrier"]
        self.duration <- map["duration"]
        self.segments <- map["segments"]
    }
}
