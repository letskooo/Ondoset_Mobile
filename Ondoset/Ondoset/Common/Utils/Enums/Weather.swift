//
//  Weather.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation
import SwiftUI

enum Weather: String {
    
    case SUNNY = "SUNNY"          // 맑음
    case PARTLY_CLOUDY = "PARTLY_CLOUDY"  // 조금 흐림
    case CLOUDY = "CLOUDY"         // 흐림
    case RAINY = "RAINY"          // 비
    case SLEET = "SLEET"          // 눈비
    case SNOWY = "SNOWY"          // 눈
}

extension Weather {
    
    var title: String {
        
        switch self {
            
        case .SUNNY:
            return "맑음"
        case .PARTLY_CLOUDY:
            return "조금 흐림"
        case .CLOUDY:
            return "흐림"
        case .RAINY:
            return "비"
        case .SLEET:
            return "눈비"
        case .SNOWY:
            return "눈"
        }
    }
}

extension Weather {
    
    var imageMain: Image {
        
        switch self {
            
        case .SUNNY:
            return Image(.sunnyMain)
        case .PARTLY_CLOUDY:
            return Image(.partlyCloudyMain)
        case .CLOUDY:
            return Image(.cloudyMain)
        case .RAINY:
            return Image(.rainyMain)
        case .SLEET:
            return Image(.sleetMain)
        case .SNOWY:
            return Image(.snowyMain)
        }
    }
    
    var imageWhite: Image {
        
        switch self {
            
        case .SUNNY:
            return Image(.sunnyWhite)
        case .PARTLY_CLOUDY:
            return Image(.partlyCloudyWhite)
        case .CLOUDY:
            return Image(.cloudyWhite)
        case .RAINY:
            return Image(.rainyWhite)
        case .SLEET:
            return Image(.sleetWhite)
        case .SNOWY:
            return Image(.snowyWhite)
        }
    }
}

extension Weather {
    /// 메인 화면 날씨 표시화면에 사용되는 큰 이미지
    var frontImage: ImageResource {
        switch self {
            
        case .SUNNY:
            return .weatherSunny
        case .PARTLY_CLOUDY:
            return .weatherPartlyCloudy
        case .CLOUDY:
            return .weatherCloudy
        case .RAINY:
            return .weatherRainy
        case .SLEET:
            return .weatherSleet
        case .SNOWY:
            return .weatherSnowy
        }
    }
}

extension Weather {
    /// 메인 화면 시간별 날씨 표시화면에 사용되는 작은 이미지
    var smallImage: ImageResource {
        switch self {
            
        case .SUNNY:
            return .sunnyMain
        case .PARTLY_CLOUDY:
            return .partlyCloudyMain
        case .CLOUDY:
            return .cloudyMain
        case .RAINY:
            return .rainyMain
        case .SLEET:
            return .sleetMain
        case .SNOWY:
            return .snowyMain
        }
    }
}

extension Weather: CaseIterable {
    /// String에서 해당하는 enum 타입으로 변환합니다.
    static func getType(from string: String) -> Weather? {
        return self.allCases.first { "\($0)" == string }
    }
}
