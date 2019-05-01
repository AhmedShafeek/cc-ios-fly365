//
//  AppConstants.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import Localize_Swift

struct AppConstants {
    
    static let protocolo    : String = "https://"
    static let apiVersion   : String = ""
    static let flightsSearchDomain : String = "api.fly365stage.com"
    static let domainAirlineImage  : String = AppConstants.protocolo + "cdn.fly365dev.com/airlines/"
    static let baseUrl : String = AppConstants.protocolo + AppConstants.flightsSearchDomain
    static let apiKey : String = "guMRjevTJNNgv49LRTNCTzfp9cWnW6Sj"
    
    struct Colors {
        static let primaryColor = "1f2d4b"
        static let colorPrimaryLite = "253559"
        static let secondaryColor = "253559"
        static let grayColor = "cccccc"
    }
    
    static let FLIGHTS_TYPE: [FlightType] = [
        FlightType(type: TypeOfFlights.oneWay, selected: true),
        FlightType(type: TypeOfFlights.roundTrip, selected: false),
        FlightType(type: TypeOfFlights.multiCity, selected: false)
    ]
    
    static let CABIN_CLASS: [Item] = [
        Item(id: 4, name: "economy".localized()),
        Item(id: 8, name: "premium_economy".localized()),
        Item(id: 1, name: "business".localized()),
        Item(id: 2, name: "first".localized())
    ]
}
