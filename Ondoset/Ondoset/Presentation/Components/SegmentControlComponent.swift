//
//  SegmentControlComponent.swift
//  Ondoset
//
//  Created by 박민서 on 4/24/24.
//

import SwiftUI

enum MyClosetTab: String, CaseIterable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case outer = "아우터"
    case shoes = "신발"
    case accessory = "악세사리"
}

struct SegmentControlComponent: View {
    
    @Binding var selectedTab: Int
    let tabMenus: [String]
    let isMain: Bool
    
    var body: some View {
        ZStack() {
            Divider()
                .background(.lightGray)
                .offset(CGSize(width: 0, height: 16.3))
            
            LazyHGrid( rows: [GridItem(.flexible())]) {
                ForEach(tabMenus.indices, id: \.self) { index in
                    Button(action: {
                        self.$selectedTab.wrappedValue = index
                        print(index)
                    }){
                        Text(tabMenus[index])
                            .font(Font.pretendard(isMain ? .bold : .medium, size: isMain ? 17 : 15))
                            .foregroundStyle(selectedTab == index ? .main : .darkGray)
                            .underline(selectedTab == index, color: .main)
                            .baselineOffset(10)
                            .padding(.horizontal, isMain ? 10 : 5)
                            .padding(.top, 10)
                    }
                }
            }
        }
        .frame(height: 44)
        
    }
}

#Preview {
    SegmentControlComponent(selectedTab: .constant(0), tabMenus: MyClosetTab.allCases.map{$0.rawValue}, isMain: false)
}
