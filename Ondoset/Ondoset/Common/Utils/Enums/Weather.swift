//
//  Weather.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation
import SwiftUI

enum Weather {
    
    case SUNNY          // 맑음
    case PARTLY_CLOUDY  // 조금 흐림
    case CLOUDY         // 흐림
    case RAINY          // 비
    case SLEET          // 눈비
    case SNOWY          // 눈
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
    var frontImage: Image {
        switch self {
            
        case .SUNNY:
            return Image(.weatherSunny)
        case .PARTLY_CLOUDY:
            return Image(.weatherPartlyCloudy)
        case .CLOUDY:
            return Image(.weatherCloudy)
        case .RAINY:
            return Image(.weatherRainy)
        case .SLEET:
            return Image(.weatherSleet)
        case .SNOWY:
            return Image(.weatherSnowy)
        }
    }
}
