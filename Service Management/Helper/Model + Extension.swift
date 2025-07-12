//
//  Model + Extension.swift
//  Service Management
//
//  Created by Manikandan Arumugam on 12/07/25.
//

import ServicesSampleData
import SwiftUI

extension ServiceStatus {
    var color: Color {
        switch self {
        case .active:
            return .blue
        case .scheduled, .completed:
            return .green
        case .inProgress:
            return .yellow
        case .urgent:
            return .red
        }
    }
}

extension Priority {
    var getColor: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .blue
        case .high:
            return .yellow
        case .critical:
            return .red
        }
    }
}

extension Service {
    var getdate: String {
        let type = Date().getSpecificType(with: scheduledDate)
        let date = Date().getDateString(withFormat: type == .other ? DateFormat.OtherDate.rawValue : DateFormat.TimeFormat.rawValue)
        
        switch type {
        case .other:
            return "\(date)"
        case .today:
            return "Today, \(date)"
        case .tomorrow:
            return "Tomorrow, \(date)"
        case .yesterday:
            return "Yesterday, \(date)"
        }
    }
}
