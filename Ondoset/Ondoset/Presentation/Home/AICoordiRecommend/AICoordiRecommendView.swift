//
//  AICoordiRecommendView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

struct AICoordiRecommendView: View {
    @StateObject var AICoordiRecommendVM: AICoordiRecommendViewModel = .init()
//    @State var saveAvailable: Bool = true
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Divider()
            // 코디 선택 스크롤 뷰
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(AICoordiRecommendVM.clothesData.indices, id: \.self) { index in
                        ClothUnSelectedComponent(
                            clothTemplate: .init(
                                category: AICoordiRecommendVM.clothesData[index].category,
                                name: AICoordiRecommendVM.clothesData[index].name,
                                searchMode: false,
                                cloth: AICoordiRecommendVM.clothesData[index].cloth
                            ),
                            width: 340,
                            additionBtn: AnyView(
                                Button(action: {
                                    AICoordiRecommendVM.deleteClothes(with: index)
                                }, label: {
                                    Image(systemName: "xmark")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                })
                                .padding()
                            ), searchText: ""
                        )
                    }
                }
            }
            // 바텀 뷰
            VStack {
                HStack {
                    Image(.noOOTDList)
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    Text("추울 것 같아요!\n등록하려면 태그별 옷을 지정해주세요")
                        .multilineTextAlignment(.center)
                        .font(.pretendard(.regular, size: 15))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ondosetBackground)
                        )
                }
                .padding()
                ButtonComponent(isBtnAvailable: .constant(false), width: 340, btnText: "3/17 코디로 등록하기", radius: 15, action: {})
            }
            .clipShape(.rect(cornerRadii: .init(topLeading: 10, bottomLeading: 0, bottomTrailing: 0, topTrailing: 10)))
        }
        .navigationTitle("AI 코디 추천")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}, label: {
                    Text("닫기")
                        .font(.pretendard(.semibold, size: 15))
                        .foregroundStyle(.gray)
                })
            }
        }
    }
}

#Preview {
    AICoordiRecommendView()
}



