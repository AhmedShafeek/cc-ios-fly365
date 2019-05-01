//
//  Double.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation

extension Double {
    
    func formatPrice() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.currencySymbol = ""
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
