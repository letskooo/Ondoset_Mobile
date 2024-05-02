//
//  AICoordiRecommendView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

struct AICoordiRecommendView: View {
    
    @State var clothesData: [Clothes] = ClothesDTO.mockData()
    @State var saveAvailable: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16, content: {
                ForEach(clothesData, id: \.clothesId) { item in
                    ClothSelectedComponent(
                        category: item.category,
                        clothName: item.name,
                        clothTag: item.tag,
                        clothThickness: item.thickness,
                        width: screenWidth - 40,
                        additionBtn: AnyView(ClothOptionButton(clothesId: item.clothesId))
                    )
                }
            })
        }
        .padding(.vertical, 20)
        .navigationTitle("AI 코디 추천")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {dismiss()}, label: {
                    Text("닫기")
                        .font(.pretendard(.semibold, size: 15))
                        .foregroundStyle(.gray)
                })
            }
        }
    }
}



#Preview {
    ClothUnSelectedComponent(category: .BOTTOM, clothName: "뜻뜻한 바지", width: 340, additionBtn: AnyView(
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: "xmark")
                .foregroundStyle(.black)
                .padding()
        })
    ))
}
