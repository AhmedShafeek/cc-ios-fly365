//
//  InitiateItineraryDto.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

class BookingRequestDto : Mappable {
    
    var itinerary : Itinerary = Itinerary()
    var id : String!
    
    public init(itinerary : Itinerary) {
        self.itinerary = itinerary
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.itinerary <- map["itinerary"]
        self.id <- map["id"]
    }
}
