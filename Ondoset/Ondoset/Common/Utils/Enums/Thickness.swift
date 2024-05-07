//
//  Thickness.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation
import SwiftUI

enum Thickness: String, CaseIterable {
    
    case THIN = "THIN"       // 얇은
    case NORMAL = "NORMAL"     // 적당한
    case THICK = "THICK"      // 두꺼운
}

extension Thickness {
    
    var color: Color {
        
        switch self {
            
        case .THIN:
            return Color("Thin")
        case .NORMAL:
            return Color("Normal")
        case .THICK:
            return Color("Thick")
        }
    }
    
    var lightColor: Color {
        
        switch self {
            
        case .THIN:
            return Color("Thin-light")
        case .NORMAL:
            return Color("Normal-light")
        case .THICK:
            return Color("Thick-light")
        }
    }
}

extension Thickness {
    
    var title: String {
        
        switch self {
            
        case .THIN:
            return "얇은"
        case .NORMAL:
            return "적당한"
        case .THICK:
            return "두꺼운"
        }
    }
}
