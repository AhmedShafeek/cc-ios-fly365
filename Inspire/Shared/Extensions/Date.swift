//
//  Date.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation

extension Date {
    
    static func changeDaysBy(days : Int) -> Date {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: currentDate)!
    }
    
    static func afterDate(date : Date, days : Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: date)!
    }
    
    func formatDate(dateString : String, fromFormat : String, toFormat : String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toFormat
        
        let finalDate = dateFormatterGet.date(from: dateString)
        return dateFormatterPrint.string(from: finalDate!)
    }
    
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let finalDate = dateFormatterGet.date(from: self.description)
        return dateFormatterPrint.string(from: finalDate!)
    }
    
    func formatDate(format : String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        let finalDate = dateFormatterGet.date(from: self.description)
        return dateFormatterPrint.string(from: finalDate!)
    }
    
    func getDate(date : String, format : String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        
        let finalDate = dateFormatterGet.date(from: date)
        return finalDate!
    }
    
    func getDate(date : Date, format : String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        
        return dateFormatterGet.string(from: date)
    }
}
