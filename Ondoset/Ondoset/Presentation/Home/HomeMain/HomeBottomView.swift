//
//  HomeBottomView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

struct HomeBottomView: View {
    // State
    @State var currentPage: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HomeBottomHeaderView()
            TodaysSetUpView()
            HomeBottomFooterView(currentPage: $currentPage)
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
        VStack {
            // 옷 표시 스크롤뷰
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
            Spacer()
            // 추위미터기 버튼
            // TODO: 해당 버튼 컴포넌트에 색 지정 부분도 추가해야 합니다
            ButtonComponent(isBtnAvailable: $test, width: 340, btnText: "추위 미터기 확인하기", radius: 15, action: { print("날 죽여라")})
                .padding()
        }
    }
}
// MARK: SetUpHistoryView
// MARK: AIRecommendView
// MARK: OthersOOTDView

// MARK: HomeBottomFooterView
struct HomeBottomFooterView: View {
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<4) { page in
                Circle()
                    .fill(page == currentPage ? Color.main : Color.gray)
                    .frame(width: 5, height: 5)
                    .onTapGesture {
                        currentPage = page
                    }
            }
        }
        .padding()
    }
}

#Preview {
    HomeBottomView()
}
