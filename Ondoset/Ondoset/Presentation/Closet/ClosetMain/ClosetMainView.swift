//
//  ClosetMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct ClosetMainView: View {
    // MARK: States
    @State var selectedTab: Int = 1
    
    // mock data
    @State var clothesData: [Clothes] = ClothesDTO.mockData()
    
    var body: some View {
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        // MARK: Main View
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                SegmentControlComponent(selectedTab: $selectedTab, tabMenus: MyClosetTab.allCases.map{$0.rawValue})
                    .padding(.bottom, 15)
                
                SearchBarComponent(placeHolder: "등록한 옷을 검색하세요", searchAction: {
                    text in
                    print(text)
                })
                .padding(.horizontal, 18)
                
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
            }
        }
        .overlay{
            Button(action: {
                print("add!")
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: 64, height: 64)
                        .foregroundStyle(.ondosetBackground)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 1, y: 5)
                    Image(.icTop)
                        .frame(width: 40, height: 40)
                    Image(.addWhiteButton)
                        .frame(width: 12, height: 12)
                        .offset(x: 15, y: -15)
                }
                
                    
            })
            .offset(x: 145, y: 290)
        }

    }
}

#Preview {
    ClosetMainView()
}
