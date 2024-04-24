//
//  MyClothingView.swift
//  Ondoset
//
//  Created by 박민서 on 4/25/24.
//

import SwiftUI

struct MyClothingView: View {
    // MARK: States
    @State var myClothing:Clothes? = nil
    @State var myClothingName: String = ""
    
    var body: some View {
        // MARK: Main View
        ClothingRowItemView(rowTitle: "아이템 이름", rowSubTitle: "15자 이내로 작성해주세요", isAddImage: true, content: AnyView(TextFieldComponent(width: 270, placeholder: "사용자님이 알아볼만한 이름을 작성해주세요", font: .pretendard(.semibold, size: 10),inputText: $myClothingName)))
        Divider()
        ClothingRowItemView(rowTitle: "카테고리", content: <#T##AnyView#>)
    }
}

struct ClothingRowItemView: View {
    
    let rowTitle: String
    var rowSubTitle: String? = nil
    var isAddImage: Bool = false
    var content: AnyView
   
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(rowTitle)
                        .font(.pretendard(.semibold, size: 17))
                        .foregroundStyle(.black)
                    if let rowSubTitle = rowSubTitle {
                        Text(rowSubTitle)
                            .font(.pretendard(.regular, size: 10))
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 4)
                
                content
            }
            if isAddImage {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(.addStrokeButton)
                        .frame(width: 72, height: 72)
                })
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

#Preview {
    MyClothingView()
}
