//
//  FlightsSearchViewController.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

extension FlightsSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.item == lastIndex && lastIndex != 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: ButtonsCell.stringRepresentation) as! ButtonsCell
            (cell as! ButtonsCell).loadCell(bound: self.bounds[0], index: indexPath.item, noOfCells : self.bounds.count)
            (cell as! ButtonsCell).addTripButton.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
            (cell as! ButtonsCell).searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        }
        else if self.bounds[0].type == TypeOfFlights.oneWay {
            cell = tableView.dequeueReusableCell(withIdentifier: OneWayCell.stringRepresentation) as! OneWayCell
            (cell as! OneWayCell).loadCell(bound: bounds[indexPath.item], index: indexPath.item)
            (cell as! OneWayCell).departureDateView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.departureDateAction), index: indexPath.item))
            (cell as! OneWayCell).passengersView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.passengersAction), index: indexPath.item))
            (cell as! OneWayCell).cabinClassView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.cabinClassAction), index: indexPath.item))
            (cell as! OneWayCell).flexibleDatesCB.button.addTarget(self, action: #selector(flexibleDatesAction), for: .touchUpInside)
            (cell as! OneWayCell).directFlightsCB.button.addTarget(self, action: #selector(directFlightsAction), for: .touchUpInside)
            (cell as! OneWayCell).flexibleDatesCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.flexibleDatesAction)))
            (cell as! OneWayCell).directFlightsCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.directFlightsAction)))
        }
        else if self.bounds[0].type == TypeOfFlights.roundTrip {
            cell = tableView.dequeueReusableCell(withIdentifier: RoundTripCell.stringRepresentation) as! RoundTripCell
            (cell as! RoundTripCell).loadCell(bound: bounds[indexPath.item], index: indexPath.item)
            (cell as! RoundTripCell).departureDateView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.departureDateAction), index: indexPath.item))
            (cell as! RoundTripCell).arrivalDateView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.arrivalDateAction), index: indexPath.item))
            (cell as! RoundTripCell).passengersView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.passengersAction), index: indexPath.item))
            (cell as! RoundTripCell).cabinClassView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.cabinClassAction), index: indexPath.item))
            (cell as! RoundTripCell).flexibleDatesCB.button.addTarget(self, action: #selector(flexibleDatesAction), for: .touchUpInside)
            (cell as! RoundTripCell).directFlightsCB.button.addTarget(self, action: #selector(directFlightsAction), for: .touchUpInside)
            (cell as! RoundTripCell).flexibleDatesCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.flexibleDatesAction(sender:))))
            (cell as! RoundTripCell).directFlightsCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.directFlightsAction)))
        }
        else if self.bounds[0].type == TypeOfFlights.multiCity {
            cell = tableView.dequeueReusableCell(withIdentifier: MultiCityCell.stringRepresentation) as! MultiCityCell
            (cell as! MultiCityCell).loadCell(bound: bounds[indexPath.item], index: indexPath.item, noOfCells : self.bounds.count)
            (cell as! MultiCityCell).departureDateView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.departureDateAction), index: indexPath.item))
            (cell as! MultiCityCell).passengersView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.passengersAction), index: indexPath.item))
            (cell as! MultiCityCell).cabinClassView.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.cabinClassAction), index: indexPath.item))
            (cell as! MultiCityCell).closeCardIV.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.closeCardAction), index: indexPath.item))
            (cell as! MultiCityCell).flexibleDatesCB.button.addTarget(self, action: #selector(flexibleDatesAction), for: .touchUpInside)
            (cell as! MultiCityCell).directFlightsCB.button.addTarget(self, action: #selector(directFlightsAction), for: .touchUpInside)
            (cell as! MultiCityCell).flexibleDatesCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.flexibleDatesAction)))
            (cell as! MultiCityCell).directFlightsCB.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.directFlightsAction)))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.bounds.count + 1
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.item == lastIndex && lastIndex != 0  {
            return (39 * 2) + (30 * 2) + 10
        }
        else if self.bounds[0].type == TypeOfFlights.oneWay {
            return 53 * 7
        }
        else if self.bounds[0].type == TypeOfFlights.roundTrip {
            return 53 * 8
        }
        else if self.bounds[0].type == TypeOfFlights.multiCity {
            if indexPath.item != 0 {
                return 53 * 4
            }
            return 50 * 8
        }
        else {
            return 0
        }
    }
}

extension FlightsSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConstants.FLIGHTS_TYPE.count
    }
    
    ///Custom cell for collection view , show data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FlightTypesCell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightTypesCell.stringRepresentation, for: indexPath) as! FlightTypesCell
        cell.loadCell(flightType: AppConstants.FLIGHTS_TYPE[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 , height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.bounds[0].type == AppConstants.FLIGHTS_TYPE[indexPath.item].type {
            return
        }
        self.searchTV.scrollsToTop = true
        for index in 0 ..< AppConstants.FLIGHTS_TYPE.count {
            AppConstants.FLIGHTS_TYPE[index].selected = false
        }
        AppConstants.FLIGHTS_TYPE[indexPath.item].selected = true
        self.searchTypeCV.reloadData()
        
        let mainBound : Bounds = self.bounds[0]
        mainBound.type = AppConstants.FLIGHTS_TYPE[indexPath.item].type
        self.bounds = [mainBound]
        if AppConstants.FLIGHTS_TYPE[indexPath.item].type == TypeOfFlights.multiCity {
            self.addTrip()
        }
        
        self.searchTV.reloadData()
        self.searchTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
}
