//
//  ClothUnSelectedComponent.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI
import Kingfisher

struct ClothUnSelectedComponent: View {
    // 옷 카테고리
    let category: Category
    
    // 옷 이름
    let clothName: String
    
    // 너비
    let width: CGFloat
    
    // 우측에 들어가는 내용
    var additionBtn: AnyView? = nil
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 80)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .overlay {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(category.lightColor)
                
                HStack(spacing: 10) {
                    
                    // 카테고리 이미지
                    category.categoryImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                    
                    Rectangle()
                        .foregroundStyle(category.color)
                        .frame(width: 2, height: 36)
                    
                    HStack(alignment: .center) {
                        
                        Text(clothName)
                            .font(Font.pretendard(.semibold, size: 17))
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black)
                        })
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
                    if let additionalButton = self.additionBtn {
                        additionalButton
                    }
                    
                }
                .padding(.leading, 18)
            }
    }
}
