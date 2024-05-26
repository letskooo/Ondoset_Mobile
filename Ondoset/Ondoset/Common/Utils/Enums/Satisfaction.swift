//
//  Satisfaction.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation
import SwiftUI

enum Satisfaction: String, CaseIterable {
    
    case VERY_COLD = "VERY_COLD"  // 매우 추웠어요
    case COLD = "COLD"       // 추웠어요
    case GOOD = "GOOD"       // 적당했어요
    case HOT = "HOT"        // 더웠어요
    case VERY_HOT = "VERY_HOT"   // 매우 더웠어요
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

extension Satisfaction {
    
    var image: Image {
        
        switch self {
            
        case .VERY_COLD:
            return Image(.VERY_COLD)
            
        case .COLD:
            return Image(.COLD)
            
        case .GOOD:
            return Image(.good)
//            return Image(.GOOD)
            
        case .HOT:
            return Image(.HOT)
            
        case .VERY_HOT:
            return Image(.VERY_HOT)
        }
    }
}
