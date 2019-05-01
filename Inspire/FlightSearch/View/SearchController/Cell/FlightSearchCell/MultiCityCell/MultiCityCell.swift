//
//  MultiCityCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class MultiCityCell: UITableViewCell {

    @IBOutlet weak var closeCardIV: MyImageView!
    @IBOutlet weak var boundNumber: MyLabel!
    @IBOutlet weak var passengersHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passengersTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var departureView: LabelImageView!
    @IBOutlet weak var arrivalView: LabelImageView!
    @IBOutlet weak var passengersView: LabelImageView!
    @IBOutlet weak var departureDateView: LabelImageView!
    @IBOutlet weak var cabinClassView: LabelImageView!
    @IBOutlet weak var flexibleDatesCB: CheckBoxView!
    @IBOutlet weak var directFlightsCB: CheckBoxView!
    let cards = ["first_trip", "second_rip", "third_trip", "fourth_trip", "fifth_rip", "sixth_trip"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(bound: Bounds, index: Int, noOfCells: Int) {
        if index == 0 {
            self.passengersHeightConstraint.constant = 37
            self.passengersTopConstraint.constant = 15
            self.passengersView.isHidden = false
            self.cabinClassView.isHidden = false
            self.flexibleDatesCB.isHidden = false
            self.directFlightsCB.isHidden = false
        }
        else {
            self.passengersHeightConstraint.constant = 0
            self.passengersTopConstraint.constant = 0
            self.passengersView.isHidden = true
            self.cabinClassView.isHidden = true
            self.flexibleDatesCB.isHidden = true
            self.directFlightsCB.isHidden = true
        }
        
        if index == 0 || (index == 1 && noOfCells == 2) {
            self.closeCardIV.isHidden = true
        }
        else {
            self.closeCardIV.isHidden = false
        }
        
        self.boundNumber.text = self.cards[index].localized()
        
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

        self.departureDateView.label.text = defultDate(date : bound.departureDate)

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
