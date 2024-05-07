//
//  Category.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
    
    case TOP = "TOP"        // 상의
    case BOTTOM = "BOTTOM"  // 하의
    case OUTER = "OUTER"    // 아우터
    case SHOE = "SHOE"      // 신발
    case ACC = "ACC"        // 악세서리
}

extension Category {
    
    var title: String {
        
        switch self {
            
        case .TOP:
            return "상의"
        case .BOTTOM:
            return "하의"
        case .OUTER:
            return "아우터"
        case .SHOE:
            return "신발"
        case .ACC:
            return "악세서리"
        }
    }
}

// 카테고리 색
extension Category {
    
    var color: Color {
        
        switch self {
        case .TOP:
            return Color("Top")
        case .BOTTOM:
            return Color("Bottom")
        case .OUTER:
            return Color("Outer")
        case .SHOE:
            return Color("Shoe")
        case .ACC:
            return Color("Acc")
        }
    }
    
    var lightColor: Color {
        
        switch self {
            
        case .TOP:
            return Color("Top-light")
        case .BOTTOM:
            return Color("Bottom-light")
        case .OUTER:
            return Color("Outer-light")
        case .SHOE:
            return Color("Shoe-light")
        case .ACC:
            return Color("Acc-light")
        }
    }
}

// 카테고리 이미지
extension Category {
    
    var categoryImage: Image {
        
        switch self {
            
        case .TOP:
            return Image(.top)
        case .BOTTOM:
            return Image(.bottom)
        case .OUTER:
            return Image(.outer)
        case .SHOE:
            return Image(.shoe)
        case .ACC:
            return Image(.accessory)
        }
    }
}
