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
    
    static func string(epoch: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(epoch))
        
        return DateFormatter.dateOnly.string(from: date)
    }
}
