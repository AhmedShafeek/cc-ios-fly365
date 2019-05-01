//
//  Segment.swift
//  Fly365
//
//  Created by Ahmed Shafeek on 4/30/19.
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class Segment : Mappable {
    
    var segmentId : String!
    var origin : AirportObj!
    var destination : AirportObj!
    var stops : [Stops]!
    var fuellingStops : [AirportObj]!
    var carrier : Carrier!
    var baggage : String!
    var flightInfo : FlightInfo!
    var cabinClass : String!
    var stopOvertime : Int!
    var bookingInfo : BookingInfo!
    var seatCount : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.segmentId <- map["segmentId"]
        self.origin <- map["origin"]
        self.destination <- map["destination"]
        self.stops <- map["stops"]
        self.fuellingStops <- map["fuellingStops"]
        self.carrier <- map["carrier"]
        self.baggage <- map["baggage"]
        self.flightInfo <- map["flightInfo"]
        self.cabinClass <- map["cabinClass"]
        self.stopOvertime <- map["stopOvertime"]
        self.bookingInfo <- map["bookingInfo"]
        self.seatCount <- map["seatCount"]
    }
}

class AirportObj : Mappable {
    
    var airportCode : String!
    var code : String!
    var departureTime : Time!
    var arrivalTime : Time!
    var terminal : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.airportCode <- map["airportCode"]
        self.code <- map["code"]
        self.departureTime <- map["departureTime"]
        self.arrivalTime <- map["arrivalTime"]
        self.terminal <- map["terminal"]
    }
}

class Time : Mappable {
    
    var date : String!
    var time : String!
    var zone : String!
    var gds : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.date <- map["date"]
        self.time <- map["time"]
        self.zone <- map["zone"]
        self.gds <- map["gds"]
    }
}

class Carrier : Mappable {
    
    var code : String!
    var name : String!
    var flightNumber : String!
    var codeShare : CodeShare!
    var aircraft : Aircraft!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.name <- map["name"]
        self.flightNumber <- map["flightNumber"]
        self.codeShare <- map["codeShare"]
        self.aircraft <- map["aircraft"]
    }
}

class CodeShare : Mappable {
    
    var code : String!
    var name : String!
    var flightNumber : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.name <- map["name"]
        self.flightNumber <- map["flightNumber"]
    }
}

class FlightInfo : Mappable {
    
    var distance : Int!
    var flightTime : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.distance <- map["distance"]
        self.flightTime <- map["flightTime"]
    }
}

class BookingInfo : Mappable {
    
    var bookingCode : String!
    var bookingCount : String!
    var fareBasis : String!
    var cabinClass : String!
    var cabinCode : String!
    
    public init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.bookingCode <- map["bookingCode"]
        self.bookingCount <- map["bookingCount"]
        self.fareBasis <- map["fareBasis"]
        self.cabinClass <- map["cabinClass"]
        self.cabinCode <- map["cabinCode"]
    }
}
