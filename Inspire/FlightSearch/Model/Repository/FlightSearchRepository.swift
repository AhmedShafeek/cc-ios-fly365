//
//  FlightSearchRepository.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import ObjectMapper

enum FlightSearchResponse {
    case success(result: FlightResult)
    case failure
}

class FlightSearchRepository: BaseService {
    
    func getFlightSearch(params: JsonDictionay, completion: @escaping (FlightSearchResponse) -> Void ) {
        let endPoint = FlightsEndPoint().getFlights
        super.callEndPoint(endPoint: endPoint, method: .post, params : params) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let code, let result):
                if code == 200 {
                    strongSelf.parseResult(result: result, completion: completion)
                }
                else {
                    completion(.failure)
                }
                break
            default:
                completion(.failure)
                break
            }
        }
    }
    
    private func parseResult(result: JsonDictionay,completion: @escaping (FlightSearchResponse) -> Void) {
        print(result)
        let flightResult : FlightResult = Mapper<FlightResult>().map(JSON: result)!
        for itinerary in flightResult.itineraries {
            for leg in itinerary.legs {
                let getLeg = flightResult.legs.filter { $0.legId == leg }.first!
                getLeg.originOBJ = flightResult.airports.filter { $0.code == getLeg.origin }.first!
                getLeg.destinationOBJ = flightResult.airports.filter { $0.code == getLeg.destination }.first!
                itinerary.legsOBJ.append(getLeg)
            }
            for leg in itinerary.legsOBJ {
                for segment in leg.segments {
                    leg.segmentsOBJ.append(flightResult.segments.filter { $0.segmentId == segment }.first!)
                }
            }
        }
//        guard let data = SearchError(json: result) else {
//            completion(.failure)
//            return
//        }
        completion(.success(result: flightResult))
    }
}
