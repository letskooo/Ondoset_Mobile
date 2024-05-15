//
//  ClothDetailComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 5/9/24.
//

import SwiftUI
import Kingfisher

struct ClothDetailComponent: View {
    
    let clothes: Clothes
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .bottom) {
                
                if let imageURL = clothes.imageURL {
                    
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .aspectRatio(7/6, contentMode: .fit)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 15)
                    
                } else {
                    
                    clothes.category.categoryImage
                        .resizable()
                        .aspectRatio(7/6, contentMode: .fit)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 15)
              
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    
                    if let thickness = clothes.thickness {
                        
                        Text("\(thickness.title)")
                            .font(Font.pretendard(.semibold, size: 13))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 5)
                            .background(thickness.color)
                            .cornerRadius(30)
                        
                    }
                    
                    Text("\(clothes.tag)")
                        .font(Font.pretendard(.semibold, size: 13))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(clothes.category.color)
                        .cornerRadius(30)
                }
                .padding(.trailing, 15)
                .padding(.bottom, 20)
            }
            
            Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .foregroundStyle(clothes.category.color)
                .padding(.bottom, 3)
            
            HStack {
                Text("\(clothes.name)")
                    .font(Font.pretendard(.medium, size: 15))
                    .padding(.leading, 15)
                    .padding(.bottom, 10)
                
                Spacer()
            }
        }
        .aspectRatio(13/7, contentMode: .fit)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10)) // 모서리를 둥글게
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(clothes.category.color, lineWidth: 2) // 빨간색 둥근 모서리 테두리 추가
        )
    }
}

#Preview {
    ClothDetailComponent(clothes: Clothes(clothesId: 1, name: "엄마가 사주신 검은 미키마우스 티셔츠", category: .SHOE, tag: "상의 태그", tagId: 1))
}
