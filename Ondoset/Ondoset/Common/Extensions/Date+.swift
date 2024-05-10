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
}
