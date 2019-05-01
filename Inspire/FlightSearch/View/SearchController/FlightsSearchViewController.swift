//
//  FlightsSearchViewController.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class FlightsSearchViewController: UIViewController, ChooseDateProtocol, ChoosePassengerProtocol, ChooseItemProtocol {

    @IBOutlet weak var searchTV: UITableView!
    @IBOutlet weak var searchTypeCV: UICollectionView!
    @IBOutlet weak var buttonsView: UIView!
    var bounds : [Bounds] = [Bounds(type: TypeOfFlights.oneWay)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTV.reloadData()
        self.searchTypeCV.reloadData()
        self.searchTV.estimatedRowHeight = 100
    }
    
    @objc func addTrip() {
        let lastIndex = self.bounds.count - 1
        if self.bounds.count < 6 {
            if self.bounds[lastIndex].arrivalAirport != nil {
                self.bounds.append(Bounds(type: TypeOfFlights.multiCity, departureAirport : self.bounds[lastIndex].arrivalAirport, departureDate : Date.afterDate(date: self.bounds[lastIndex].departureDate, days: 1)))
            }
            else {
                self.bounds.append(Bounds(type: TypeOfFlights.multiCity, departureDate : Date.afterDate(date: self.bounds[lastIndex].departureDate, days: 1)))
            }
            self.searchTV.reloadData()
        }
    }
    
    /////////////////////////
    @objc func departureDateAction(sender : MyTapGestureRecognizer) {
        let requestCode = sender.index
        let viewController : DatePickerDialog = DatePickerDialog(nibName: DatePickerDialog.stringRepresentation, bundle: Bundle.main)
        viewController.modalPresentationStyle = .overCurrentContext
        if requestCode! > 0 {
            viewController.departureDate = self.bounds[requestCode!-1].departureDate
        }
        viewController.defultDate = self.bounds[0].departureDate
        viewController.chooseDateProtocol = self
        viewController.dateType = DateType.Departure
        viewController.requestCode = requestCode
        self.present(viewController, animated: true)
    }
    
    @objc func arrivalDateAction(sender : MyTapGestureRecognizer) {
        let requestCode = sender.index
        let viewController : DatePickerDialog = DatePickerDialog(nibName: DatePickerDialog.stringRepresentation, bundle: Bundle.main)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.chooseDateProtocol = self
        viewController.dateType = DateType.Arrival
        viewController.requestCode = requestCode
        viewController.defultDate = self.bounds[0].arrivalDate
        viewController.departureDate = self.bounds[0].departureDate
        self.present(viewController, animated: true)
    }
    
    func chooseDate(type: DateType, date: Date, requestCode: Int) {
        if type == DateType.Departure {
            self.bounds[requestCode].departureDate = date
            if self.bounds[0].type == TypeOfFlights.multiCity {
                for i in (1..<bounds.count).sorted() {
                    if self.bounds[i].departureDate < self.bounds[i-1].departureDate {
                        self.bounds[i].departureDate = Date.afterDate(date: self.bounds[i-1].departureDate , days: 1)
                    }
                }
            }
            else {
                if date > self.bounds[requestCode].arrivalDate {
                    self.bounds[requestCode].arrivalDate = Date.afterDate(date: date, days: 1)
                }
            }
        }
        else {
            self.bounds[requestCode].arrivalDate = date
        }
        self.searchTV.reloadData()
    }
    
    //////////////////////////
    @objc func passengersAction(sender : UITapGestureRecognizer) {
        let viewController : PassengerDialog = PassengerDialog(nibName: PassengerDialog.stringRepresentation, bundle: Bundle.main)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.choosePassengerProtocol = self
        viewController.passenger = self.bounds[0].passengers
        self.present(viewController, animated: true)
    }
    
    func choosePassenger(passengers: PassengerType) {
        self.bounds[0].passengers = passengers
        self.searchTV.reloadData()
    }
    
    ///////////////////////////
    @objc func cabinClassAction(sender : UITapGestureRecognizer) {
        let viewController : SelectItemDialog = SelectItemDialog(nibName: SelectItemDialog.stringRepresentation, bundle: Bundle.main)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.chooseItemProtocol = self
        viewController.requestCode = 0
        viewController.items = AppConstants.CABIN_CLASS
        self.present(viewController, animated: false)
    }
    
    func chooseItem(item: Item, requestCode: Int) {
        self.bounds[0].cabinClass = item
        self.searchTV.reloadData()
    }
    
    ////////////////////////////
    @objc func closeCardAction(sender : MyTapGestureRecognizer) {
        let index = sender.index
        self.bounds.remove(at: index!)
        self.searchTV.reloadData()
    }
    
    ////////////////////////////
    @objc func flexibleDatesAction(sender : MyButton) {
        self.bounds[0].flexibleDates = !self.bounds[0].flexibleDates
        self.searchTV.reloadData()
    }
    
    ////////////////////////////
    @objc func directFlightsAction(sender : MyButton) {
        self.bounds[0].directFlights = !self.bounds[0].directFlights
        self.searchTV.reloadData()
    }
    
    ///////////////////////////
    @objc func searchAction(sender : UITapGestureRecognizer) {
        if !checkValidation() {
            return
        }
        let viewController : FlightsResultsViewController = self.storyboard!.instantiateViewController(withIdentifier: FlightsResultsViewController.stringRepresentation) as! FlightsResultsViewController
        viewController.bounds = bounds
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func checkValidation() -> Bool {
        for i in (0..<self.bounds.count).reversed() {
            if self.bounds[i].departureAirport == nil ||
                self.bounds[i].arrivalAirport == nil {
                self.bounds[i].error = true
                self.searchTV.reloadData()
                return false
            }
        }
        return true
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    
    var index: Int?
    
    init(target: Any?, action: Selector?, index: Int?) {
        super.init(target: target, action: action)
        self.index = index
    }
}
