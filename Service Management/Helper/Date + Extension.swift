//
//  Date + Extension.swift
//  Service Management
//
//  Created by Manikandan Arumugam on 12/07/25.
//

import Foundation

extension Date {
    
    func getDateString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getSpecificType(with input: String) -> SpecificDate {
        let date = getDate(with: input)
        let calender = Calendar.current
        if calender.isDateInToday(date) {
            return .today
        } else if calender.isDateInYesterday(date) {
            return .yesterday
        } else if calender.isDateInTomorrow(date) {
            return .tomorrow
        } else {
            return .other
        }
    }
    
    func getDate(with input: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.TimeStamp.rawValue
        guard let date = dateFormatter.date(from: input) else {
            return Date()
        }
        
        return date
    }
}


enum SpecificDate {
    case today
    case tomorrow
    case yesterday
    case other
}

enum DateFormat: String {
    case TimeFormat = "HH:mm a"
    case OtherDate = "dd/MM/yyyy, HH:mm a"
    case TimeStamp = "yyyy-MM-dd'T'HH:mm:ssZ"
}
