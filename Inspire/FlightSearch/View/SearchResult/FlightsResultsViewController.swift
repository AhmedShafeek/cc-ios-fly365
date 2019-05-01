//
//  FlightsResultsViewController.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit
import NotificationBannerSwift

enum SortType : String {
    case Price
    case Duration
    case Departure
    case Arrival
}

class FlightsResultsViewController: UIViewController, FlightSearchViewModelDelegate, FilterProtocol {

    @IBOutlet weak var filterFloatingView: FloatingView!
    @IBOutlet weak var priceButton: MyButton!
    @IBOutlet weak var durationButton: MyButton!
    @IBOutlet weak var departureButton: MyButton!
    @IBOutlet weak var arrivalButton: MyButton!
    @IBOutlet weak var noresultLabel: MyLabel!
    @IBOutlet weak var flightsTV: MyTableView!
    var originItinerary : [Itinerary] = []
    var itinerary : [Itinerary] = []
    var itineraryFilter : ItineraryFilter = ItineraryFilter()
    var flightSearchViewModel = FlightSearchViewModel()
    var bounds : [Bounds]!
    var currency : String!
    var flightsLoaded = false
    var sortType : SortType = SortType.Price
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.bounds[0].departureDate.description)
        self.title = "results".localized()
        self.flightSearchViewModel.delegate = self
        self.flightSearchViewModel.getFlights(bounds: bounds)
        self.flightsTV.reloadData()
        self.filterFloatingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.filterAction)))
    }
    
    @objc func filterAction() {
        let viewController : FilterViewController = self.storyboard!.instantiateViewController(withIdentifier: FilterViewController.stringRepresentation) as! FilterViewController
        viewController.currency = self.currency
//        viewController.itinerary = self.itinerary
        viewController.originItinerary = self.originItinerary
        viewController.itineraryFilter = self.itineraryFilter
        viewController.filterProtocol = self
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    func applyFilter(itinerary: [Itinerary], itineraryFilter : ItineraryFilter) {
        self.itinerary = self.sortItinerary(itineraries: itinerary, sortType: sortType)
        self.itineraryFilter = itineraryFilter
        self.flightsTV.reloadData()
        self.flightsTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    func reloadTable(flightResult : FlightResult) {
        DispatchQueue.main.sync {
            self.originItinerary = flightResult.itineraries
            if self.originItinerary.count > 1 {
                self.filterFloatingView.isHidden = false
            }
            self.itinerary = flightResult.itineraries
            self.sortStyle(sortType: SortType.Price)
            self.currency = flightResult.meta.currency
            self.noresultLabel.isHidden = (self.itinerary.count != 0)
            self.flightsLoaded = true
            self.flightsTV.estimatedRowHeight = UITableView.automaticDimension
            self.flightsTV.rowHeight = UITableView.automaticDimension
            self.flightsTV.reloadData()
            self.flightsTV.layoutIfNeeded()
            self.flightsTV.heightAnchor.constraint(equalToConstant: self.flightsTV.contentSize.height).isActive = true
        }
    }
    
    func failure() {
        DispatchQueue.main.sync {
            self.navigationController?.popViewController(animated: false)
            let banner = NotificationBanner(title: "error".localized(), subtitle: "invalid_search_request".localized(), style: .danger)
            banner.show()
        }
    }
    
    func sortItinerary(itineraries : [Itinerary], sortType : SortType) -> [Itinerary] {
        var sortedArray : [Itinerary] = []
        self.sortType = sortType
        self.sortStyle(sortType: sortType)
        switch sortType {
        case SortType.Price:
            sortedArray = itineraries.sorted { $0.pricing.total < $1.pricing.total }
            return sortedArray
        case SortType.Duration:
            sortedArray = itineraries.sorted { sortByDuration(itinerary : $0) < sortByDuration(itinerary : $1) }
            return sortedArray
        case SortType.Departure:
            sortedArray = itineraries.sorted { $0.legsOBJ[0].departureDate < $1.legsOBJ[0].departureDate }
            return sortedArray
        case SortType.Arrival:
            sortedArray = itineraries.sorted { $0.legsOBJ[0].arrivalDate < $1.legsOBJ[0].arrivalDate }
            return sortedArray
        }
    }
    
    func sortStyle(sortType : SortType) {
        switch sortType {
        case SortType.Price:
            self.priceButton.textColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            self.durationButton.textColor = UIColor.black
            self.durationButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.departureButton.textColor = UIColor.black
            self.departureButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.arrivalButton.textColor = UIColor.black
            self.arrivalButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            break
        case SortType.Duration:
            self.priceButton.textColor = UIColor.black
            self.priceButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.durationButton.textColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.durationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            self.departureButton.textColor = UIColor.black
            self.departureButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.arrivalButton.textColor = UIColor.black
            self.arrivalButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            break
        case SortType.Departure:
            self.priceButton.textColor = UIColor.black
            self.priceButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.durationButton.textColor = UIColor.black
            self.durationButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.departureButton.textColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.departureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            self.arrivalButton.textColor = UIColor.black
            self.arrivalButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            break
        case SortType.Arrival:
            self.priceButton.textColor = UIColor.black
            self.priceButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.durationButton.textColor = UIColor.black
            self.durationButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.departureButton.textColor = UIColor.black
            self.departureButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            self.arrivalButton.textColor = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.arrivalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            break
        }
    }
    
    func sortByDuration(itinerary : Itinerary) -> Int {
        var duration = 0
        for leg in itinerary.legsOBJ {
            duration += leg.duration
        }
        return duration
    }
    
    func calclateDuration(time : String) -> Int {
        if time.contains(".") {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd.HH:mm:ss"
            
            let date = dateFormatterGet.date(from: time)
            let calendar = Calendar.current
            
            let day = calendar.component(.day, from: date!)
            let hour = calendar.component(.hour, from: date!)
            let minutes = calendar.component(.minute, from: date!)
            
            return (day * 24 * 60) + (hour * 60) + (minutes)
        }
        else {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "HH:mm:ss"
            
            let date = dateFormatterGet.date(from: time)
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date!)
            let minutes = calendar.component(.minute, from: date!)
            return (hour * 60) + (minutes)
        }
    }
    
    @IBAction func priceSortAction(_ sender: Any) {
        self.itinerary = sortItinerary(itineraries: self.itinerary, sortType: SortType.Price)
        self.flightsTV.reloadData()
        self.flightsTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    @IBAction func durationSortAction(_ sender: Any) {
        self.itinerary = sortItinerary(itineraries: self.itinerary, sortType: SortType.Duration)
        self.flightsTV.reloadData()
        self.flightsTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    @IBAction func departureSortAction(_ sender: Any) {
        self.itinerary = sortItinerary(itineraries: self.itinerary, sortType: SortType.Departure)
        self.flightsTV.reloadData()
        self.flightsTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    @IBAction func arrivalSortAction(_ sender: Any) {
        self.itinerary = sortItinerary(itineraries: self.itinerary, sortType: SortType.Arrival)
        self.flightsTV.reloadData()
        self.flightsTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
}
