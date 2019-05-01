//
//  FlightSearchViewModel.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation

protocol FlightSearchViewModelDelegate: class {
    func reloadTable(flightResult : FlightResult)
    func failure()
}

class FlightSearchViewModel {
    
    var repository: FlightSearchRepository?
    weak var delegate: FlightSearchViewModelDelegate?
    
    init() {
        repository = FlightSearchRepository()
    }
    
    func getFlights(bounds: [Bounds]) {
        guard let repo = repository else { return }
        print(mapData(bounds: bounds))
        repo.getFlightSearch(params: mapData(bounds: bounds)) { [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.delegate?.reloadTable(flightResult: result)
            case.failure:
                strongSelf.delegate?.failure()
                break
            }
        }
    }
    
    func mapData(bounds: [Bounds]) -> JsonDictionay {
        var legs : [Leg] = []
        for i in (0..<bounds.count).sorted() {
            legs.append(Leg(origin: bounds[i].departureAirport.code, destination: bounds[i].arrivalAirport.code, departureDate: defultDate(date : bounds[i].departureDate)))
            if bounds[0].type == TypeOfFlights.roundTrip && i == 0 {
                legs.append(Leg(origin: bounds[i].arrivalAirport.code, destination: bounds[i].departureAirport.code, departureDate: defultDate(date : bounds[i].arrivalDate)))
            }
        }
        let flightSearchPost : FlightSearchDto = FlightSearchDto(legs: legs,
            adult: bounds[0].passengers.adults,
            child: bounds[0].passengers.children,
            infant: bounds[0].passengers.lapInfants,
            cabinClass: bounds[0].cabinClass.name)
        return flightSearchPost.toJSON()
    }
    
    func defultDate(date : Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        let finalDate = dateFormatterGet.date(from: date.description)
        return dateFormatterPrint.string(from: finalDate!)
    }
}
