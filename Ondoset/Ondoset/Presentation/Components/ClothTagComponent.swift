//
//  TagComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import SwiftUI

struct TagComponent: View {
    
    @Binding var isSelected: Bool
    
    let tagContent: String
    let category: Category
    
    var body: some View {
        
        Text(tagContent)
            .font(Font.pretendard(.semibold, size: 13))  // 글꼴 설정
            .padding(.horizontal, 20)  // 수평 패딩 추가
            .padding(.vertical, 5)     // 수직 패딩 추가
            .background(isSelected ? category.color : category.lightColor)  // 배경색
            .foregroundColor(isSelected ? .white : category.color)  // 텍스트 색상
            .cornerRadius(30)  // 모서리 둥글게
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(category.color, lineWidth: 1)  // 테두리 추가
            )
    }
}

#Preview {
    TagComponent(isSelected: .constant(false), tagContent: "아우터", category: .OUTER)
}
