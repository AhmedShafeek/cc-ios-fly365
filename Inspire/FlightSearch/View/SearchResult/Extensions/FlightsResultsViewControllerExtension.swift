//
//  FlightsResultsViewControllerExtension.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

extension FlightsResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if flightsLoaded {
            cell = tableView.dequeueReusableCell(withIdentifier: FlightResultCell.stringRepresentation) as! FlightResultCell
            (cell as! FlightResultCell).loadCell(itinerary : self.itinerary[indexPath.item], currency : currency)
            (cell as! FlightResultCell).layoutSubviews()
            (cell as! FlightResultCell).layoutIfNeeded()
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.stringRepresentation) as! LoadingCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flightsLoaded {
            return  self.itinerary.count
        }
        else {
            return 10
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if flightsLoaded {
            return UITableView.automaticDimension
        }
        else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flightsLoaded {
        }
    }
}
