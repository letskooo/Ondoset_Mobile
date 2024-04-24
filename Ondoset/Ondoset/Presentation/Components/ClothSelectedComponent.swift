//
//  ClothSelectedComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/22/24.
//

import SwiftUI
import Kingfisher

struct ClothSelectedComponent: View {
    
    @State var tagSelected: Bool = true

    // 옷 카테고리
    let category: Category
    
    // 옷 이미지
    let clothImage: String? = nil
    
    // 옷 이름
    let clothName: String
    
    // 옷 태그
    let clothTag: String
    
    // 옷 두께
    let clothThickness: Thickness
    
    // 너비
    let width: CGFloat
    
    // 우측에 들어가는 내용
    let additionBtn: AnyView? = nil
    
    var body: some View {
        
        Rectangle()
            .frame(width: width, height: 80)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .overlay {
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(category.color)
                
                HStack(spacing: 10) {
                    
                    if let imageURL = clothImage {
                        
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                    } else {
                        
                        // 카테고리 이미지
                        category.categoryImage
                    }
                    
                    Rectangle()
                        .foregroundStyle(category.lightColor)
                        .frame(width: 2, height: 36)
                    
                    VStack(alignment: .leading) {
                        
                        Text(clothName)
                            .font(Font.pretendard(.semibold, size: 15))
                                        
                        HStack {
                            
                            ClothTagComponent(isSelected: $tagSelected, tagTitle: clothTag, category: category)
                            
                            ThicknessTagComponent(isSelected: $tagSelected, thickness: clothThickness)
                            
                        }
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
                    if additionBtn != nil {
                        
                        additionBtn
                        padding(.trailing, 20)
                    }
                }
                .padding(.leading, 18)
            }
    }
}

#Preview {
    ClothSelectedComponent(tagSelected: true, category: .TOP, clothName: "가천 후드티", clothTag: "후드티", clothThickness: .THICK, width: screenWidth - 40)
}
