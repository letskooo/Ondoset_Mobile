//
//  Satisfaction.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation

enum Satisfaction {
    
    case VERY_COLD  // 매우 추웠어요
    case COLD       // 추웠어요
    case GOOD       // 적당했어요
    case HOT        // 더웠어요
    case VERY_HOT   // 매우 더웠어요
}

extension Satisfaction {
    
    var title: String {
        
        switch self {
            
        case .VERY_COLD:
            return "매우 추웠어요"
        case .COLD:
            return "추웠어요"
        case .GOOD:
            return "적당했어요"
        case .HOT:
            return "더웠어요"
        case .VERY_HOT:
            return "매우 더웠어요"
        }
    }
}
