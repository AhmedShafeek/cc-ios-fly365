//
//  BoundResultCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit
import Localize_Swift
import Kingfisher

class BoundResultCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nextDayArrivalLabel: UILabel!
    @IBOutlet weak var airlineIV: UIImageView!
    @IBOutlet weak var departureAirportLabel: MyLabel!
    @IBOutlet weak var arrivalAirportLabel: MyLabel!
    @IBOutlet weak var aircraftLabel: MyLabel!
    @IBOutlet weak var priceLabel: MyLabel!
    @IBOutlet weak var timeFromLabel: MyLabel!
    @IBOutlet weak var timeToLabel: MyLabel!
    @IBOutlet weak var elapsedTimeLabel: MyLabel!
    @IBOutlet weak var noOfStopsLabel: MyLabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(leg : Leg, totalPrice : String, currency : String, lastIndex : Bool) {
        if leg.stops > 1 {
            self.airlineIV.image = #imageLiteral(resourceName: "multtiple_airlines")
        }
        else {
            self.airlineIV.kf.setImage(with: URL(string: AppConstants.domainAirlineImage + leg.segmentsOBJ[0].carrier.code + ".png"), placeholder: #imageLiteral(resourceName: "departure_flight"))
        }
        
        if let originOBJ = leg.originOBJ {
            self.departureAirportLabel.text = "\(originOBJ.cityName!) (\(originOBJ.code!))"
        }
        
        if let destinationOBJ = leg.destinationOBJ {
            self.arrivalAirportLabel.text = "\(destinationOBJ.cityName!) (\(destinationOBJ.code!))"
        }
        
        self.noOfStopsLabel.text = "(\(String(leg.stops)) \("stop".localized()))"
        if leg.stops == 0 {
            self.noOfStopsLabel.text = "(\("non_stop".localized()))"
            self.noOfStopsLabel.textColor = UIColor.init(hexString: "00AB66")
        }
        else if leg.stops == 2 || leg.stops == 1 {
            self.noOfStopsLabel.textColor = UIColor.orange
        }
        else {
            self.noOfStopsLabel.textColor = UIColor.red
        }
        
        self.elapsedTimeLabel.text = (leg.duration != nil) ? "\(formatDuration(time: leg.duration!))" : ""
        self.aircraftLabel.text = leg.segmentsOBJ.map{return $0.carrier.aircraft.name}.joined(separator: ",")
        self.priceLabel.text = "\(currency) \(String(totalPrice))"
        self.timeFromLabel.text = Date().formatDate(dateString: leg.departureDate, fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: "hh:mm a")
        self.timeToLabel.text = Date().formatDate(dateString: leg.arrivalDate, fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: "hh:mm a")
        self.nextDayArrivalLabel.isHidden = (leg.departureDate == leg.arrivalDate)
        
        if lastIndex {
            self.lineView.isHidden = true
            self.priceLabel.isHidden = false
        }
        else {
            self.lineView.isHidden = false
            self.priceLabel.isHidden = true
            self.priceLabel.text = ""
        }
    }
    
    func formatDuration(time : Int) -> String {
        return "\(0)\("day".localized()) \(0)\("h".localized()) \(0)\("min".localized())"
    }
}

