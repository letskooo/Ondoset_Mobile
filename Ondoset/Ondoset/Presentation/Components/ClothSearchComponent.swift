//
//  ClothSearchComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 5/8/24.
//

import SwiftUI
import Kingfisher

struct ClothSearchComponent: View {
    
    let clothes: Clothes

    var body: some View {
        
        VStack(spacing: 0) {
            
            if let imageURL = clothes.imageURL {
                
                KFImage(URL(string: imageURL))
                    .resizable()
                    .aspectRatio(7/6, contentMode: .fit)
//                    .frame(height: screenHeight / 5.8)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
                
            } else {
                
                clothes.category.categoryImage
                    .resizable()
                    .aspectRatio(7/6, contentMode: .fit)
//                    .frame(height: screenHeight / 5.8)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
            }
            
            Rectangle()
                .frame(width: screenWidth / 4, height: 1)
                .foregroundStyle(clothes.category.color)
                .padding(.bottom, 3)
            
            Text(clothes.name)
                .font(Font.pretendard(.semibold, size: 15))
                .lineLimit(1)
                .padding(.vertical, 8)
                .padding(.bottom, 5)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10)) // 모서리를 둥글게
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(clothes.category.color, lineWidth: 2) // 빨간색 둥근 모서리 테두리 추가
        )
    }
}

#Preview {
    ClothSearchComponent(clothes: Clothes(clothesId: 1, name: "찢어진 청바지", category: .SHOE, tag: "청바지", tagId: 2))
}
