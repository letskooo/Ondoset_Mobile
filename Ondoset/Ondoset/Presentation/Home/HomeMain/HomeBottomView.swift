//
//  HomeBottomView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

struct HomeBottomView: View {
    var body: some View {
        VStack(spacing: 0) {
            HomeBottomHeaderView()
            TodaysSetUpView()
        }
        .background(Color.ondosetBackground)
    }
}

struct HomeBottomHeaderView: View {
    // properties
    var isOOTD: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘은 이렇게 입기로 했어요!")
                    .font(.pretendard(.semibold, size: 17))
                Spacer()
                if isOOTD {
                    Button(action: {}, label: {
                        HStack(spacing: 0) {
                            Text("OOTD")
                                .font(.pretendard(.semibold, size: 13))
                            Image(systemName: "chevron.forward")
                        }
                        .foregroundStyle(.main)
                    })
                }
            }
            Divider()
                .frame(height: 2)
                .overlay(Color.white)
        }
        .padding()
    }
}

// MARK: TodaysSetUpView
struct TodaysSetUpView: View {
    // states
    @State var test: Bool = true
    
    // property
    let setUp: [Clothes] = [
        .init(clothesId: 0, name: "asdf", category: .ACC, tag: "asdf", thickness: .NORMAL),
        .init(clothesId: 1, name: "zvxc", category: .OUTER, tag: "asdf", thickness: .THIN),
        .init(clothesId: 2, name: "aㅁㄴf", category: .BOTTOM, tag: "asdf", thickness: .NORMAL),
        .init(clothesId: 3, name: "zvxㅁ", category: .OUTER, tag: "asdf", thickness: .THIN),
        .init(clothesId: 4, name: "asdf", category: .TOP, tag: "asdf", thickness: .THICK),
        .init(clothesId: 5, name: "zvㅇc", category: .SHOE, tag: "asdf", thickness: .THIN),
        .init(clothesId: 6, name: "zvxㅁㄴ", category: .OUTER, tag: "asdf", thickness: .THIN),
        .init(clothesId: 7, name: "asdfasdfasdff", category: .TOP, tag: "asdf", thickness: .THICK),
        .init(clothesId: 8, name: "zvㅇㄴㄹㄴㅁㅇㄹxc", category: .SHOE, tag: "asdf", thickness: .THIN),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [
                GridItem(.flexible(), spacing: 10, alignment: .leading),
                GridItem(.flexible(), spacing: 10, alignment: .leading),
                GridItem(.flexible(), spacing: 10, alignment: .leading)
            ], content: {
                ForEach(setUp, id: \.clothesId) { cloth in
                    ClothTagComponent(isSelected: $test, tagTitle: cloth.name, category: cloth.category)
                }
            })
            .frame(height: 100)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        
    }
}
// MARK: SetUpHistoryView
// MARK: AIRecommendView
// MARK: OthersOOTDView

#Preview {
    HomeBottomView()
}
