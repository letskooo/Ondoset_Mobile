//
//  SegmentControlComponent.swift
//  Ondoset
//
//  Created by 박민서 on 4/24/24.
//

import Foundation

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
    
    var body: some View {
        ZStack() {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(tabMenus.indices, id: \.self) { index in
                    Button(action: {
                        self.selectedTab = index
                    }){
                        Text(tabMenus[index])
                            .font(Font.pretendard(.bold, size: 17))
                            .foregroundStyle(selectedTab == index ? .blue : .darkGray)
                            .underline(selectedTab == index, color: .blue)
                            .baselineOffset(10)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                    }
                }
            }
            Divider()
                .offset(CGSize(width: 0, height: 16.5))
        }
        
        
    }
}

#Preview {
    SegmentControlComponent(selectedTab: .constant(0), tabMenus: MyClosetTab.allCases.map{$0.rawValue})
}
