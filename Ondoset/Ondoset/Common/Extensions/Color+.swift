//
//  Color+.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//


/// Hex 값으로 색상을 출력하기 위한 extension 정의 파일입니다.

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255
        )
    }
}
