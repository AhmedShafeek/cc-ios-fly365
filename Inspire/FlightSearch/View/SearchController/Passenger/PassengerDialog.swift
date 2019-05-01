//
//  PassengerDialog.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

class PassengerDialog: UIViewController {
    
    @IBOutlet weak var lapInfantsAddIV: MyImageView!
    @IBOutlet weak var lapInfantsMinIV: MyImageView!
    @IBOutlet weak var lapInfantsLabel: MyLabel!
    @IBOutlet weak var childrenAddIV: MyImageView!
    @IBOutlet weak var childrenMinIV: MyImageView!
    @IBOutlet weak var childrenLabel: MyLabel!
    @IBOutlet weak var adultsAddIV: MyImageView!
    @IBOutlet weak var adultsMinIV: MyImageView!
    @IBOutlet weak var adultsLabel: MyLabel!
    @IBOutlet weak var bgView: UIView!
    var choosePassengerProtocol : ChoosePassengerProtocol!
    var requestCode : Int!
    var passenger : PassengerType = PassengerType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.backAction)))
        self.adultsMinIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.adultsMinAction)))
        self.adultsAddIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.adultsAddAction)))
        self.childrenMinIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.childrenMinAction)))
        self.childrenAddIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.childrenAddAction)))
        self.lapInfantsMinIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.lapInfantsMinAction)))
        self.lapInfantsAddIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.lapInfantsAddAction)))
        self.updateView()
    }
    
    @objc func backAction() {
        self.dismiss(animated: true) {
            self.choosePassengerProtocol.choosePassenger(passengers : self.passenger)
        }
    }
    
    @objc func adultsMinAction() {
        if self.passenger.adults > 1 {
            self.passenger.adults -= 1
            if self.passenger.lapInfants > self.passenger.adults {
                self.passenger.lapInfants = self.passenger.adults
            }
            self.updateView()
        }
    }
    
    @objc func adultsAddAction() {
        if self.passenger.adults < 9 - self.passenger.children {
            self.passenger.adults += 1
            self.updateView()
        }
    }
    
    @objc func childrenMinAction() {
        if self.passenger.children > 0 {
            self.passenger.children -= 1
            self.updateView()
        }
    }
    
    @objc func childrenAddAction() {
        if self.passenger.children < 9 - self.passenger.adults {
            self.passenger.children += 1
            self.updateView()
        }
    }
    
    @objc func lapInfantsMinAction() {
        if self.passenger.lapInfants > 0 {
            self.passenger.lapInfants -= 1
            self.updateView()
        }
    }
    
    @objc func lapInfantsAddAction() {
        if self.passenger.lapInfants < self.passenger.adults {
            self.passenger.lapInfants += 1
            self.updateView()
        }
    }
    
    func updateView() {
        ////////
        if self.passenger.adults + self.passenger.children == 9 {
            self.adultsAddIV.color = UIColor.lightGray
            if self.passenger.adults == 1 {
                self.adultsMinIV.color = UIColor.lightGray
            }
            else {
                self.adultsMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
            }
        }
        else if self.passenger.adults == 1 {
            self.adultsMinIV.color = UIColor.lightGray
            self.adultsAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.adultsAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.adultsMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        ///////
        if self.passenger.children + self.passenger.adults == 9 {
            self.childrenAddIV.color = UIColor.lightGray
            if self.passenger.children == 0 {
                self.childrenMinIV.color = UIColor.lightGray
            }
            else {
                self.childrenMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
            }
        }
        else if self.passenger.children == 0 {
            self.childrenMinIV.color = UIColor.lightGray
            self.childrenAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.childrenAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.childrenMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        ///////
        if self.passenger.lapInfants == self.passenger.adults {
            self.lapInfantsAddIV.color = UIColor.lightGray
            self.lapInfantsMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else if self.passenger.lapInfants == 0 {
            self.lapInfantsMinIV.color = UIColor.lightGray
            self.lapInfantsAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        else {
            self.lapInfantsAddIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
            self.lapInfantsMinIV.color = UIColor(hexString: AppConstants.Colors.primaryColor)
        }
        self.adultsLabel.text = String(self.passenger.adults) + " " + "adults".localized()
        self.childrenLabel.text = String(self.passenger.children) + " " + "children".localized()
        self.lapInfantsLabel.text = String(self.passenger.lapInfants) + " " + "lap_infants".localized()
    }
}

protocol ChoosePassengerProtocol : AnyObject {
    func choosePassenger(passengers : PassengerType)
}
