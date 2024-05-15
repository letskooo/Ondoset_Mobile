//
//  TagComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import SwiftUI

struct ClothTagComponent: View {
    
    @Binding var isSelected: Bool
    
    let tagTitle: String
    let category: Category
    
    var body: some View {
        
        VStack {
            
            Text(tagTitle)
                .font(Font.pretendard(.semibold, size: 13))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .foregroundStyle(isSelected ? .white : category.color)
        }
        .background(isSelected ? category.color : category.lightColor)
        .cornerRadius(30)
    }
}

#Preview {
    ClothTagComponent(isSelected: .constant(false), tagTitle: "아우터", category: .OUTER)
}
