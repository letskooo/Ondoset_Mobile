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
    @State var presentMyClothing: Bool = false
    
    // mock data
    @State var clothesData: [Clothes] = ClothesDTO.mockData()
    
    var body: some View {
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        // MARK: Main View
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                SegmentControlComponent(selectedTab: $selectedTab, tabMenus: MyClosetTab.allCases.map{$0.rawValue})
                    .padding(.bottom, 15)
                
                SearchBarComponent(placeHolder: "등록한 옷을 검색하세요", searchAction: {
                    text in
                    print(text)
                })
                .padding(.horizontal, 18)
                
                if clothesData.isEmpty {
                    VStack(alignment: .center) {
                        Spacer()
                        BlankDataIndicateComponent(explainText: "아직 등록된 옷이 없어요\n오른쪽 아래의 옷 추가 버튼을 눌러 옷을 추가해주세요")
                        Spacer()
                    }
                }
                else {
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
        }
        .overlay{
            Button(action: {
                print("add!")
                self.presentMyClothing = true
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
        .sheet(isPresented: $presentMyClothing) {
            NavigationView { MyClothingView() }
        }

    }
}

#Preview {
    ClosetMainView()
}
