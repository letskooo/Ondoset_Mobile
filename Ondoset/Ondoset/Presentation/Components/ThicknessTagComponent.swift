//
//  WeatherTagComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import SwiftUI

struct ThicknessTagComponent: View {
    
    @Binding var isSelected: Bool

    let thickness: Thickness
    
    var body: some View {
        
        Text(thickness.title)
            .font(Font.pretendard(.semibold, size: 13))  // 글꼴 설정
            .padding(.horizontal, 10)  // 수평 패딩 추가
            .padding(.vertical, 4)     // 수직 패딩 추가
            .background(isSelected ? thickness.color : thickness.lightColor)  // 배경색
            .foregroundColor(isSelected ? .white : thickness.color)  // 텍스트 색상
            .cornerRadius(30)  // 모서리 둥글게
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(thickness.color, lineWidth: 1)  // 테두리 추가
            )
    }
}

#Preview {
    ThicknessTagComponent(isSelected: .constant(false), thickness: .THIN)
}
