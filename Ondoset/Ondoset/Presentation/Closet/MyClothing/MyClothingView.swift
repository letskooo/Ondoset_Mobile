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
    @State var myClothingCategory: Category? = nil
    @State var DetailedTagList: [(Int, String)] = [
        (0, "asdf"), (1, "qwer"), (2, "zxcv"), (3, "cvbn"), (4, "cvbnm"), (5, "cvbnm"), (6, "cvbnm")
    ]
    @State var myClothingDetailedTag: (Int, String) = (-1, "")
    @State var myClothingThickness: Thickness? = nil
    @State var saveAvailable: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // MARK: Main View
        ZStack {
            VStack {
                Divider()
                ClothingRowItemView(
                    rowTitle: "아이템 이름",
                    rowSubTitle: "15자 이내로 작성해주세요",
                    isAddImage: true,
                    content: AnyView(
                        TextFieldComponent(
                            width: 270,
                            placeholder: "사용자님이 알아볼만한 이름을 작성해주세요",
                            font: .pretendard(
                                .semibold,
                                size: 10
                            ),
                            inputText: $myClothingName
                        )
                    )
                )
                Divider()
                ClothingRowItemView(
                    rowTitle: "카테고리",
                    content: AnyView(
                        ScrollView(.horizontal) {
                            LazyHStack(content: {
                                ForEach(Category.allCases, id: \.self) { item in
                                    ClothTagComponent(isSelected: .constant(item == myClothingCategory), tagTitle: item.title, category: item)
                                        .onTapGesture {
                                            myClothingCategory = item
                                        }
                                }
                            })
                            .frame(height: 24)
                            .padding(4)
                        }
                            .scrollIndicators(.hidden)
                ))
                Divider()
                ClothingRowItemView(
                    rowTitle: "세부 태그",
                    content: myClothingCategory != nil
                        ? AnyView(
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], alignment: .top, spacing: 10,
                                          content: {
                                              ForEach(DetailedTagList, id: \.0) { tag in
                                                  ClothTagComponent(isSelected: .constant(tag == myClothingDetailedTag), tagTitle: tag.1, category: myClothingCategory!)
                                                      .onTapGesture {
                                                          myClothingDetailedTag = tag
                                                      }
                                              }
                                })
                                .frame(height: 60)
                                .padding(4)
                            }
                                .scrollIndicators(.hidden)
                        )
                    : AnyView(
                        Text("먼저 카테고리를 선택해주세요")
                            .font(.pretendard(.medium, size: 15))
                            .foregroundStyle(.gray)
                    )
                )
                Divider()
                ClothingRowItemView(
                    rowTitle: "두께감",
                    content: AnyView(
                        LazyHStack(alignment: .center, spacing: 40) {
                            ForEach(Thickness.allCases, id: \.self) { item in
                                ThicknessTagComponent(isSelected: .constant(item == myClothingThickness), thickness: item)
                                    .onTapGesture {
                                        myClothingThickness = item
                                    }
                            }
                        }
                            .frame(width: screenWidth-40, height: 24)
                            .padding(4)
                    )
                )
                Divider()
                Spacer()
                ButtonComponent(isBtnAvailable: $saveAvailable, width: screenWidth-40, btnText: "저장하기", radius: 15, action: { print("저장하기")
                    dismiss()
                })
                    .padding(.bottom, 30)
            }
        }
        .navigationTitle("나의 아이템 \(myClothing != nil ? "수정하기" : "추가하기")")
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
                .padding(.bottom, 4)
                
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
        .padding(.vertical, 8)
    }
}
#Preview {
    MyClothingView()
}
