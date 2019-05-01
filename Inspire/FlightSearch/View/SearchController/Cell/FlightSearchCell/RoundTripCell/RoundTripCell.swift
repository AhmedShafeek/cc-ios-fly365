//
//  FlightSearchTableViewCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class RoundTripCell: UITableViewCell {

    @IBOutlet weak var departureView: LabelImageView!
    @IBOutlet weak var arrivalView: LabelImageView!
    @IBOutlet weak var passengersView: LabelImageView!
    @IBOutlet weak var departureDateView: LabelImageView!
    @IBOutlet weak var arrivalDateView: LabelImageView!
    @IBOutlet weak var cabinClassView: LabelImageView!
    @IBOutlet weak var flexibleDatesCB: CheckBoxView!
    @IBOutlet weak var directFlightsCB: CheckBoxView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(bound: Bounds, index: Int) {
        if bound.departureAirport != nil {
            self.departureView.bgView.borderColor = UIColor(hexString: AppConstants.Colors.grayColor)
            self.departureView.label.text = bound.departureAirport.name
        }
        else if bound.error {
            self.departureView.bgView.borderColor = UIColor.red
        }
        else {
            self.departureView.label.text = "departure".localized()
        }
        
        if bound.arrivalAirport != nil {
            self.arrivalView.bgView.borderColor = UIColor(hexString: AppConstants.Colors.grayColor)
            self.arrivalView.label.text = bound.arrivalAirport.name
        }
        else if bound.error {
            self.arrivalView.bgView.borderColor = UIColor.red
        }
        else {
            self.arrivalView.label.text = "arrival".localized()
        }
//        if bound.departureDate != nil {
//            self.departureDateView.bgView.borderColor = UIColor(hexString: AppConstants.Colors.grayColor)
            self.departureDateView.label.text = defultDate(date : bound.departureDate)
//        }
//        else if bound.error {
//            self.departureDateView.bgView.borderColor = UIColor.red
//        }
//        if bound.arrivalDate != nil {
//            self.arrivalDateView.bgView.borderColor = UIColor(hexString: AppConstants.Colors.grayColor)
            self.arrivalDateView.label.text = defultDate(date : bound.arrivalDate)
//        }
//        else if bound.error {
//            self.arrivalDateView.bgView.borderColor = UIColor.red
//        }
        if index == 0 {
            self.passengersView.label.text = self.calNoOfPassengers(passengers: bound.passengers)
            self.cabinClassView.label.text = bound.cabinClass.name
            self.flexibleDatesCB.button.isChecked = bound.flexibleDates
            self.directFlightsCB.button.isChecked = bound.directFlights
        }
    }
    
    func defultDate(date : Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let finalDate = dateFormatterGet.date(from: date.description)
        return dateFormatterPrint.string(from: finalDate!)
    }
    
    func calNoOfPassengers(passengers : PassengerType) -> String {
        let adults = String(passengers.adults) + " " + "adults".localized()
        let children = String(passengers.children) + " " + "children".localized()
        let lapInfants = String(passengers.lapInfants) + " " + "lap_infants".localized()
        return adults + ", " + children + ", " + lapInfants
    }
}
