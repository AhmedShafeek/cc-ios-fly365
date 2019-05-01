//
//  FilterViewController.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class FilterViewController: UIViewController {

    @IBOutlet weak var noOfStopsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noOfStopsTV: MyTableView!
    @IBOutlet weak var aircraftHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var aircraftTV: MyTableView!
    @IBOutlet weak var airlineHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var airlinesTV: MyTableView!
    @IBOutlet weak var minPriceLabel: MyLabel!
    @IBOutlet weak var maxPriceLabel: MyLabel!
    @IBOutlet weak var priceSlider: MyMDCSlider!
    var filterProtocol : FilterProtocol!
    var originItinerary : [Itinerary] = []
    var itineraryFilter : ItineraryFilter = ItineraryFilter()
    var currency : String = ""
    var airlines : [Airline] = []
    var aircrafts : [Aircraft] = []
    var stops : [Stops] = []
    let heightOfRow = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "filter_by".localized()
        self.priceFilter()
        self.stopsFilter()
        self.airlineFilter()
        self.aircraftFilter()
    }
    
    @IBAction func clearFilterAction(_ sender: Any) {
        self.itineraryFilter = ItineraryFilter()
        self.viewDidLoad()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    func priceFilter() {
        var minPrice : Double!
        var maxPrice : Double!
        var priceValue : Double!
        let itinerarySortedByPrice : [Itinerary] = self.originItinerary.sorted { $0.pricing.total < $1.pricing.total }
        minPrice = itinerarySortedByPrice.first?.pricing.total
        maxPrice = itinerarySortedByPrice.last?.pricing.total
        self.priceSlider.minimumValue = CGFloat(minPrice)
        self.priceSlider.maximumValue = CGFloat(maxPrice)
        if self.itineraryFilter.price != nil {
            priceValue = self.itineraryFilter.price
            self.priceSlider.value = CGFloat(self.itineraryFilter.price)
        }
        else {
            priceValue = itinerarySortedByPrice.last?.pricing.total
            self.priceSlider.value = CGFloat(priceValue)
        }
        self.minPriceLabel.text = "\(currency) \(formatPrice(price : minPrice))"
        self.maxPriceLabel.text = "\(currency) \(formatPrice(price : priceValue))"
        self.priceSlider.addTarget(self,
                                   action: #selector(didChangePriceSliderValue(senderSlider:event:)),
                                   for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc func didChangePriceSliderValue(senderSlider : MyMDCSlider, event: UIEvent) {
        let senderValue = Double(senderSlider.value)
        self.maxPriceLabel.text = "\(currency) \(formatPrice(price : senderValue))"
        
        DispatchQueue.main.async {
            for stop in self.stops {
                let status = (stop.maxPriceOfItinerary <= senderValue)
                stop.checked = status
                stop.enable = status
                stop.only = false
            }
            self.noOfStopsTV.reloadData()
        }
        
        DispatchQueue.main.async {
            for airline in self.airlines {
                let status = (airline.maxPriceOfItinerary <= senderValue)
                airline.checked = status
                airline.enable = status
                airline.only = false
            }
            self.airlinesTV.reloadData()
        }
        
        DispatchQueue.main.async {
            for aircraft in self.aircrafts {
                let status = (aircraft.maxPriceOfItinerary <= senderValue)
                aircraft.checked = status
                aircraft.enable = status
                aircraft.only = false
            }
            self.aircraftTV.reloadData()
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    func calclateTimeByMin(time : Int) -> Int {
        let date = NSDate(timeIntervalSince1970: Double(time) / 1000)
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        
        return (day * 24 * 60) + (hour * 60) + (minutes)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    func stopsFilter() {
        if self.itineraryFilter.stops != nil {
            self.stops = self.itineraryFilter.stops
        }
        else {
            self.stops = self.getStops(itinerary: self.originItinerary)
        }
        self.noOfStopsTV.estimatedRowHeight = 300.0
        self.noOfStopsTV.rowHeight = UITableView.automaticDimension
        self.noOfStopsTV.reloadData()
        self.noOfStopsHeightConstraint.constant = CGFloat((self.stops.count) * heightOfRow)
    }
    
    func getStops(itinerary : [Itinerary]) -> [Stops] {
        var stops : [Stops] = []
        for itinerary in itinerary {
            for leg in itinerary.legsOBJ {
                if leg.stops == 0 {
                    stops.append(Stops(name : "direct".localized(), id: "-1", noOfStops: leg.stops, maxPriceOfItinerary : itinerary.pricing.total))
                }
                else if leg.stops == 1 {
                    stops.append(Stops(name : String(leg.stops) + " " + "stop".localized(), id: String(leg.stops), noOfStops: leg.stops, maxPriceOfItinerary : itinerary.pricing.total))
                }
                else {
                    stops.append(Stops(name : String(leg.stops) + " " + "stops".localized(), id: String(leg.stops), noOfStops: leg.stops, maxPriceOfItinerary : itinerary.pricing.total))
                }
            }
        }
        stops = stops.sorted { $0.maxPriceOfItinerary < $1.maxPriceOfItinerary }
        stops = stops.unique{$0.id}
        stops = stops.sorted { $0.noOfStops < $1.noOfStops }
        if stops.count > 1 {
            stops.insert(Stops(name : "all".localized(), id: "0", noOfStops: 0, maxPriceOfItinerary : 0), at: 0)
        }
        else {
            stops[0].dimmed = true
        }
        return stops
    }
    
    @objc func stopsSwitchOnlyChanged(mySwitch: UISwitch) {
        let index = mySwitch.tag
        self.stops.forEach { $0.checked = false }
        self.stops.forEach { $0.only = false }
        self.stops[index].only = true
        self.stops[index].checked = true
        self.noOfStopsTV.reloadData()
    }
    
    @objc func stopsCheckBoxAction(sender : MyTapGestureRecognizer) {
        let index = sender.index
        if self.stops[index!].id == "0" {
            let allCheck = self.stops[0].checked
            self.stops.forEach {
                $0.checked = !allCheck
                $0.only = false }
        }
        else {
            self.stops.filter { $0.id == "0" }.first?.checked = false
            self.stops.forEach{ $0.only = false }
            self.stops[index!].checked = !self.stops[index!].checked
        }
        self.noOfStopsTV.reloadData()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    func aircraftFilter() {
        if self.itineraryFilter.aircrafts != nil {
            self.aircrafts = self.itineraryFilter.aircrafts
        }
        else {
            self.aircrafts = self.getAircrafts(itinerary: self.originItinerary)
        }
        self.aircraftTV.estimatedRowHeight = 300.0
        self.aircraftTV.rowHeight = UITableView.automaticDimension
        self.aircraftTV.reloadData()
        self.aircraftHeightConstraint.constant = CGFloat((self.aircrafts.count) * heightOfRow)
    }
    
    func getAircrafts(itinerary : [Itinerary]) -> [Aircraft] {
        var aircraft : [Aircraft] = []
        for itinerary in itinerary {
                for segment in itinerary.legsOBJ[0].segmentsOBJ {
                        aircraft.append(Aircraft(name: segment.carrier.aircraft.name, code: segment.carrier.aircraft.code, maxPriceOfItinerary : itinerary.pricing.total))
                }
        }
        aircraft = aircraft.sorted { $0.maxPriceOfItinerary < $1.maxPriceOfItinerary }
        aircraft = aircraft.unique{$0.code}
        aircraft = aircraft.sorted { $0.name < $1.name }
        if aircraft.count > 1 {
            aircraft.insert(Aircraft(name : "all".localized(), code: "All"), at: 0)
        }
        else {
            aircraft[0].dimmed = true
        }
        return aircraft
    }
    
    @objc func aircraftSwitchOnlyChanged(mySwitch: UISwitch) {
        let index = mySwitch.tag
        self.aircrafts.forEach { $0.checked = false }
        self.aircrafts.forEach { $0.only = false }
        self.aircrafts[index].only = true
        self.aircrafts[index].checked = true
        self.aircraftTV.reloadData()
    }
    
    @objc func aircraftCheckBoxAction(sender : MyTapGestureRecognizer) {
        let index = sender.index
        if self.aircrafts[index!].code == "" {
            let allCheck = self.aircrafts[0].checked
            self.aircrafts.forEach {
                $0.checked = !allCheck
                $0.only = false }
        }
        else {
            self.aircrafts.filter { $0.code == "" }.first?.checked = false
            self.aircrafts.forEach{ $0.only = false }
            self.aircrafts[index!].checked = !self.aircrafts[index!].checked
        }
        self.aircraftTV.reloadData()
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    func airlineFilter() {
        if self.itineraryFilter.airlines != nil {
            self.airlines = self.itineraryFilter.airlines
        }
        else {
            self.airlines = self.getAirlines(itinerary: self.originItinerary)
        }
        self.airlinesTV.estimatedRowHeight = 300.0
        self.airlinesTV.rowHeight = UITableView.automaticDimension
        self.airlinesTV.reloadData()
        self.airlineHeightConstraint.constant = CGFloat((self.airlines.count) * heightOfRow)
    }
    
    func getAirlines(itinerary : [Itinerary]) -> [Airline] {
        var airlines : [Airline] = []
        for itinerary in itinerary {
                for segment in itinerary.legsOBJ[0].segmentsOBJ {
                        airlines.append(Airline(name: segment.carrier.name, id: segment.carrier.code, code: segment.carrier.code, maxPriceOfItinerary : itinerary.pricing.total))
                }
        }
        airlines = airlines.sorted { $0.maxPriceOfItinerary < $1.maxPriceOfItinerary }
        airlines = airlines.unique{$0.code}
        airlines = airlines.sorted { $0.name < $1.name }
        if airlines.count > 1 {
            airlines.insert(Airline(name : "all".localized(), id: "0", code: "All"), at: 0)
        }
        else {
            airlines[0].dimmed = true
        }
        return airlines
    }
    
    @objc func airlineCheckBoxAction(sender : MyTapGestureRecognizer) {
        let index = sender.index
        if self.airlines[index!].id == "0" {
            let allCheck = self.airlines[0].checked
            self.airlines.forEach {
                $0.checked = !allCheck
                $0.only = false }
        }
        else {
            self.airlines.filter { $0.id == "0" }.first?.checked = false
            self.airlines.forEach{ $0.only = false }
            self.airlines[index!].checked = !self.airlines[index!].checked
        }
        self.airlinesTV.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func formatPrice(price : Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.currencySymbol = ""
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: price))!
        return priceString
    }
    
    @objc func airlineSwitchOnlyChanged(mySwitch: UISwitch) {
        let index = mySwitch.tag
        self.airlines.forEach { $0.checked = false }
        self.airlines.forEach { $0.only = false }
        self.airlines[index].only = true
        self.airlines[index].checked = true
        self.airlinesTV.reloadData()
    }
    
    @IBAction func applyAction(_ sender: MyButton) {
        var filteredItineraries : [Itinerary] = []
        filteredItineraries = self.filterByPrice(itineraries: self.originItinerary)
        filteredItineraries = self.filterPriceList(itineraries: filteredItineraries)
        if filteredItineraries.count != 0 {
            self.filterProtocol.applyFilter(itinerary: filteredItineraries, itineraryFilter: itineraryFilter)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let banner = NotificationBanner(title: "filter".localized(), subtitle: "no_result_found".localized(), style: .danger)
            banner.show()
        }
    }
    
    func filterByPrice(itineraries : [Itinerary]) -> [Itinerary] {
        self.itineraryFilter.price = Double(self.priceSlider.value)
         let filteredItineraries = itineraries.filter { $0.pricing.total <= Double(self.priceSlider.value) }
        return filteredItineraries
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////
    
    func filterPriceList(itineraries : [Itinerary]) -> [Itinerary] {
        self.itineraryFilter.aircrafts = self.aircrafts
        let filteredItineraries = itineraries.filter { filterByStops(itinerary: $0) && filterByAirline(itinerary: $0) && filterByAircraft(itinerary: $0) }
        return filteredItineraries
    }
    
    func filterByStops(itinerary : Itinerary) -> Bool {
        self.itineraryFilter.stops = self.stops
        if self.stops[0].checked == true {
            return true
        }
        for stop in self.stops {
            if stop.checked && stop.enable {
                if itinerary.legsOBJ[0].stops == stop.noOfStops {
                    return true
                }
            }
        }
        return false
    }
    
    func filterByAirline(itinerary : Itinerary) -> Bool {
        self.itineraryFilter.airlines = self.airlines
        if self.airlines[0].checked == true {
            return true
        }
        for airline in self.airlines {
            if airline.checked && airline.enable {
                if (itinerary.legsOBJ[0].segmentsOBJ.filter { $0.carrier.code == airline.code }.count != 0) {
                    return true
                }
            }
        }
        return false
    }
    
    func filterByAircraft(itinerary : Itinerary) -> Bool {
        self.itineraryFilter.aircrafts = self.aircrafts
        if self.aircrafts[0].checked == true {
            return true
        }
        for aircraft in self.aircrafts {
            if aircraft.checked && aircraft.enable {
                if (itinerary.legsOBJ[0].segmentsOBJ.filter { $0.carrier.aircraft.code == aircraft.code }.count != 0) {
                    return true
                }
            }
        }
        return false
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    
    func filterByStops(itineraries : [Itinerary]) -> [Itinerary] {
        self.itineraryFilter.stops = self.stops
        if self.stops[0].checked == true {
            return itineraries
        }
        var filteredItineraries : [Itinerary] = []
        for stop in self.stops {
            if stop.checked && stop.enable {
                filteredItineraries += itineraries.filter { $0.legsOBJ.filter { $0.stops == stop.noOfStops }.count != 0 }
            }
        }
        return filteredItineraries
    }
    
    func filterByAirline(itineraries : [Itinerary]) -> [Itinerary] {
        self.itineraryFilter.airlines = self.airlines
        if self.airlines[0].checked == true {
            return itineraries
        }
        var filteredItineraries : [Itinerary] = []
        for airline in self.airlines {
            if airline.checked && airline.enable {
                filteredItineraries += itineraries.filter { $0.legsOBJ.flatMap { $0.segmentsOBJ }.filter { $0.carrier.code == airline.code }.count != 0 }
            }
        }
        return filteredItineraries
    }
    
    func filterByAircraft(itineraries : [Itinerary]) -> [Itinerary] {
        self.itineraryFilter.aircrafts = self.aircrafts
        if self.aircrafts[0].checked == true {
            return itineraries
        }
        var filteredItineraries : [Itinerary] = []
        for aircraft in self.aircrafts {
            if aircraft.checked && aircraft.enable {
                filteredItineraries += itineraries.filter { $0.legsOBJ.flatMap { $0.segmentsOBJ }.filter { $0.carrier.aircraft.code == aircraft.code }.count != 0 }
            }
        }
        return filteredItineraries
    }
}

protocol FilterProtocol : AnyObject {
    func applyFilter(itinerary : [Itinerary], itineraryFilter : ItineraryFilter)
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.airlinesTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: AirlineCell.stringRepresentation) as! AirlineCell
            cell.loadCell(airline: self.airlines[indexPath.item])
            cell.airlineCheckBox.label.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.airlineCheckBoxAction), index: indexPath.item))
            cell.airlineCheckBox.button.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.airlineCheckBoxAction), index: indexPath.item))
            cell.airlineSwitch.addTarget(self, action: #selector(airlineSwitchOnlyChanged), for: UIControl.Event.valueChanged)
            cell.airlineSwitch.tag = indexPath.item
            return cell
        }
        else if tableView == self.aircraftTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: AircraftCell.stringRepresentation) as! AircraftCell
            cell.loadCell(aircraft: self.aircrafts[indexPath.item])
            cell.aircraftCheckBox.label.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.aircraftCheckBoxAction), index: indexPath.item))
            cell.aircraftCheckBox.button.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.aircraftCheckBoxAction), index: indexPath.item))
            cell.aircraftSwitch.addTarget(self, action: #selector(aircraftSwitchOnlyChanged), for: UIControl.Event.valueChanged)
            cell.aircraftSwitch.tag = indexPath.item
            return cell
        }
        else if tableView == self.noOfStopsTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoOfStopsCell.stringRepresentation) as! NoOfStopsCell
            cell.loadCell(stops: self.stops[indexPath.item])
            cell.noOfStopsCheckBox.label.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.stopsCheckBoxAction), index: indexPath.item))
            cell.noOfStopsCheckBox.button.addGestureRecognizer(MyTapGestureRecognizer(target: self, action:  #selector(self.stopsCheckBoxAction), index: indexPath.item))
            cell.noOfStopsSwitch.addTarget(self, action: #selector(stopsSwitchOnlyChanged), for: UIControl.Event.valueChanged)
            cell.noOfStopsSwitch.tag = indexPath.item
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == airlinesTV {
            return self.airlines.count
        }
        else if tableView == aircraftTV {
            return self.aircrafts.count
        }
        else if tableView == noOfStopsTV {
            return self.stops.count
        }
        else {
            return 0
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightOfRow)
    }
}
