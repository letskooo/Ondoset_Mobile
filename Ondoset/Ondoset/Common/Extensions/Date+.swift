//
//  Date+.swift
//  Ondoset
//
//  Created by 박민서 on 5/11/24.
//

import Foundation

extension Date {
    /// 주어진 날짜에 n일을 더하여 반환
    func changeNDay(with n: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: n, to: self)!
    }
    
    /// 현재 Date를 Int 값으로 반환
    func toInt() -> Int {
        let now = self.timeIntervalSince1970 // 현재 시간을 초 단위로 가져옴
        let date = ((now + 32400) / 86400) * 86400 - 32400 // 식 계산
        let intDate = Int(date)
        return intDate
    }
}
