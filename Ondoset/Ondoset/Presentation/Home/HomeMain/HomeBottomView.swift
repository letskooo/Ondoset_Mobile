//
//  HomeBottomView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

enum HomeBottomViewType: CaseIterable {
    case TodaysSetUpView
    case SetUpHistoryView
    case AIRecommendView
    case OthersOOTDView
    
    var title: String {
        switch self {
            
        case .TodaysSetUpView:
            return "오늘은 이렇게 입기로 했어요"
        case .SetUpHistoryView:
            return "전엔 이렇게 입었어요"
        case .AIRecommendView:
            return "AI가 추천하는 오늘의 코디"
        case .OthersOOTDView:
            return "다른 사람들은 이렇게 입었어요"
        }
    }
}

struct HomeBottomView: View {
    // State
    @State var currentPage: Int = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<4) { index in
                VStack(spacing: 0) {
                    HomeBottomHeaderView(viewType: HomeBottomViewType.allCases[index])
                    switch index {
                    case 0:
                        TodaysSetUpView()
                    case 1:
                        SetUpHistoryView()
                    case 2:
                        AIRecommendView()
                    case 3:
                        OthersOOTDView()
                    default:
                        Spacer()
                    }
                    HomeBottomFooterView(currentPage: $currentPage)
                }
                .background(Color.ondosetBackground)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct HomeBottomHeaderView: View {
    
    @EnvironmentObject var homeMainVM: HomeMainViewModel
    // properties
    var viewType: HomeBottomViewType
    
    var body: some View {
        VStack {
            HStack {
                Text(viewType.title)
                    .font(.pretendard(.semibold, size: 17))
                Spacer()
                if viewType == .OthersOOTDView {
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
        .init(clothesId: 0, name: "asdf", category: .ACC, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 1, name: "zvxc", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 2, name: "aㅁㄴf", category: .BOTTOM, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 3, name: "zvxㅁ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 4, name: "asdf", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK),
        .init(clothesId: 5, name: "zvㅇc", category: .SHOE, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 6, name: "zvxㅁㄴ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 7, name: "asdfasdfasdff", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK),
        .init(clothesId: 8, name: "zvㅇㄴㄹㄴㅁㅇㄹxc", category: .SHOE, tag: "asdf", tagId: 1, thickness: .THIN),
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
struct SetUpHistoryView: View {
    // states
    @State var test: Bool = true
    
    // property
    let dates: [String] = [
        "2024.03.11",
        "2023.11.02",
        "2024.03.02"
    ]
    let setUp: [Clothes] = [
        .init(clothesId: 0, name: "asdfadsf", category: .ACC, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 1, name: "zvxc", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 2, name: "aㅁㄴf", category: .BOTTOM, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 3, name: "zvxㅁ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 4, name: "asdf", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK),
        .init(clothesId: 5, name: "zvxㅁ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 6, name: "asdf", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(dates.indices, id: \.self) { index in
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [
                        GridItem(.flexible(),spacing: 10, alignment: .leading),
                        GridItem(.flexible(), spacing: 10, alignment: .leading)
                    ]) {
                        Text(dates[index])
                            .font(Font.pretendard(.semibold, size: 13))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                            .background(index % 2 == 0 ? .white : .ondosetBackground)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                        ForEach(setUp, id: \.clothesId) { cloth in
                            ClothTagComponent(isSelected: $test, tagTitle: cloth.name, category: cloth.category)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                }
                .background(index % 2 == 0 ? .ondosetBackground : .white )
            }
        }
    }
}
// MARK: AIRecommendView
struct AIRecommendView: View {
    // states
    @State var test: Bool = true
    
    // property
    let setUp: [Clothes] = [
        .init(clothesId: 0, name: "asdfadsf", category: .ACC, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 1, name: "zvxc", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 2, name: "aㅁㄴf", category: .BOTTOM, tag: "asdf", tagId: 1, thickness: .NORMAL),
        .init(clothesId: 3, name: "zvxㅁ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 4, name: "asdf", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK),
        .init(clothesId: 5, name: "zvxㅁ", category: .OUTER, tag: "asdf", tagId: 1, thickness: .THIN),
        .init(clothesId: 6, name: "asdf", category: .TOP, tag: "asdf", tagId: 1, thickness: .THICK)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(1...3, id: \.self) { index in
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [
                        GridItem(.flexible(),spacing: 10, alignment: .leading),
                        GridItem(.flexible(), spacing: 10, alignment: .leading)
                    ]) {
                        Text("#\(index)")
                            .font(Font.pretendard(.semibold, size: 13))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(index % 2 == 0 ? .ondosetBackground : .white )
                            .foregroundColor(.black)
                            .cornerRadius(30)
                        ForEach(setUp, id: \.clothesId) { cloth in
                            ClothTagComponent(isSelected: $test, tagTitle: cloth.name, category: cloth.category)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                }
                .background(index % 2 == 0 ? .white : .ondosetBackground  )
            }
        }
    }
}
// MARK: OthersOOTDView
struct OthersOOTDView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 3) {
                OOTDComponent(date: "2024.03.08", minTemp: nil, maxTemp: nil, ootdImageURL: "ㅎㅇ")
                    .background(.ondosetBackground)
                OOTDComponent(date: "2024.03.08", minTemp: nil, maxTemp: nil, ootdImageURL: "ㅎㅇ")
                    .background(.ondosetBackground)
                OOTDComponent(date: "2024.03.08", minTemp: nil, maxTemp: nil, ootdImageURL: "ㅎㅇ")
                    .background(.ondosetBackground)
            }
            .padding(3)
            .background(.white)
            Spacer()
        }
    }
}
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
