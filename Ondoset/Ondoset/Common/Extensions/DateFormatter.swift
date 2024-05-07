//
//  DateFormatter.swift
//  Ondoset
//
//  Created by KoSungmin on 5/1/24.
//

import Foundation

extension DateFormatter {
    
    static let shared = DateFormatter()
    
    static let dateOnly: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static func string(epoch: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(epoch))
        
        return DateFormatter.dateOnly.string(from: date)
    }
    
    static func timeString(epoch: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(epoch))
        return DateFormatter.timeOnly.string(from: date)
    }
}
