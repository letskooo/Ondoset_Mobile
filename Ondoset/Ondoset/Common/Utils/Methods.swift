//
//  Methods.swift
//  Ondoset
//
//  Created by KoSungmin on 5/27/24.
//

import Foundation


// MARK: 시간 관련 전역 메소드

/// 특정 시간이 현재 시간보다 과거인지 판별하는 메소드
func isDatePast(year: Int, month: Int, day: Int) -> Bool {
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day

    guard let date = calendar.date(from: dateComponents) else {
        print("Invalid date")
        return false
    }

    let now = Date()
    let makePast = -24 * 60 * 60
    let today = now.addingTimeInterval(TimeInterval(makePast))

    return date < today
}

/// 연, 월, 일을 에포크 타임으로 변환하는 메소드(오버로드)
func epochTimeFrom(year: Int, month: Int, day: Int) -> Int? {
    
    var calendar = Calendar.current
    
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    guard let date = calendar.date(from: components) else { return nil }
    
    return Int(date.timeIntervalSince1970) - 32400
}

/// 연, 월, 일, 시간을 에포크 타임으로 변환하는 메소드(오버로드)
func epochTimeFrom(year: Int, month: Int, day: Int, hour: Int) -> Int? {
    
    var calendar = Calendar.current
    
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    
    guard let date = calendar.date(from: components) else { return nil }
    
    return Int(date.timeIntervalSince1970) - 32400
    
}
