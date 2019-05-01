//
//  Bounds.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation

class Bounds {
    
    var type : TypeOfFlights!
    var departureAirport : Airport = Airport(code : "CAI", name : "Cairo International Airport, Egypt")
    var arrivalAirport : Airport = Airport(code : "DXB", name : "Dubai, United Arab Emirates")
    var departureDate : Date = Date.afterDate(date: Date(), days: 5)
    var arrivalDate : Date = Date.afterDate(date: Date(), days: 6)
    var passengers : PassengerType = PassengerType()
    var cabinClass : Item = AppConstants.CABIN_CLASS[0]
    var flexibleDates : Bool = false
    var directFlights : Bool = false
    var error = false
    
    public init(type : TypeOfFlights) {
        self.type = type
    }
    
    public init(type : TypeOfFlights, departureAirport : Airport, departureDate : Date) {
        self.type = type
        self.departureAirport = departureAirport
        self.departureDate = departureDate
    }
    
    public init(type : TypeOfFlights, departureDate : Date) {
        self.type = type
        self.departureDate = departureDate
    }
}
