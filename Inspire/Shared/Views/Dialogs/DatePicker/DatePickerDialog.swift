//
//  DatePickerDialog.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

enum DateType : String {
    case Departure
    case Arrival
    case Birthdate
}

class DatePickerDialog: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bgView: UIView!
    var chooseDateProtocol : ChooseDateProtocol!
    var requestCode : Int!
    var dateType : DateType!
    var departureDate : Date!
    var defultDate : Date!
    var maxDate : Date!
    var minDate : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.backAction)))
        if departureDate != nil {
            self.datePicker.minimumDate = Date.afterDate(date : departureDate!, days : 1)
            self.datePicker.maximumDate = Date.afterDate(date : departureDate!, days : 365)
        }
        else if maxDate != nil {
            self.datePicker.maximumDate = maxDate
        }
        else if minDate != nil {
            self.datePicker.minimumDate = minDate
        }
        else {
            self.datePicker.minimumDate = Date.changeDaysBy(days : 1)
            self.datePicker.maximumDate = Date.changeDaysBy(days : 365)
        }
        self.datePicker.date = defultDate
    }
    
    @objc func backAction() {
        self.dismiss(animated: true)
    }
    
    @IBAction func chooseAction(_ sender: MyButton) {
        self.dismiss(animated: true) {
            self.chooseDateProtocol.chooseDate(type: self.dateType, date: self.datePicker.date, requestCode: self.requestCode)
        }
    }
}

protocol ChooseDateProtocol : AnyObject {
    func chooseDate(type : DateType, date: Date, requestCode : Int)
}
