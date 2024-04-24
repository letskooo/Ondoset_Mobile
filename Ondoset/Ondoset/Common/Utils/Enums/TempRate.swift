//
//  TempRate.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation

enum TempRate {
    
    case T28        // 28도 ~
    case T23        // 23 ~ 27도
    case T20        // 20 ~ 22도
    case T17        // 17 ~ 19도
    case T12        // 12 ~ 16도
    case T9         // 9 ~ 11도
    case T5         // 5 ~ 8도
    case TElse      // ~ 4도
}

extension TempRate {
    
    var section: String {
        
        switch self {
            
        case .T28:
            return "28°C ~"
        case .T23:
            return "23 ~ 27°C"
        case .T20:
            return "20 ~ 22°C"
        case .T17:
            return "17 ~ 19°C"
        case .T12:
            return "12 ~ 16°C"
        case .T9:
            return "9 ~ 11°C"
        case .T5:
            return "5 ~ 8°C"
        case .TElse:
            return "~ 4°C"
        }
    }
}
