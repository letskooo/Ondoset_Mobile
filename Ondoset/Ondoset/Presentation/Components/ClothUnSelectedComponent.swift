//
//  ClothUnSelectedComponent.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI
import Kingfisher

struct ClothUnSelectedComponent: View {
    
    /// 옷 템플릿
    let clothTemplate: ClothTemplate
    /// ClothTemplate 인덱스
    let cellIndex: Range<Array<ClothTemplate>.Index>.Element
    
    /// 서치모드
    @Binding var searchMode: Bool
    
    @StateObject var clothSearchVM : ClothSearchViewModel = .init()
    
    // 너비
    let width: CGFloat
    // 우측에 들어가는 내용
    var additionBtn: AnyView? = nil
    
//    let test: [Clothes] =  ClothesDTO.mockData()
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: searchMode ? 360 : 80)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .overlay(alignment: .top) {
                ZStack {
                    // 카테고리 존재하는 경우
                    if let category = clothTemplate.category {
                        // clothes 선택한 경우
                        if let clothes = clothTemplate.cloth {
                            ClothSelectedComponent(
                                category: clothes.category,
                                clothName: clothes.name,
                                clothTag: clothes.tag,
                                clothThickness: clothes.thickness,
                                width: 340,
                                additionBtn: AnyView(
                                    Button(action: {
                                        NotificationCenter.default.post(name: NSNotification.Name("DeleteCloth"), object: nil, userInfo: ["index": cellIndex])
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                    })
                                    .padding()
                                )
                            )
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(category.lightColor)
                            
                            VStack {
                                HStack(spacing: 10) {
                                    
                                    // 카테고리 이미지
                                    category.categoryImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 48, height: 48)
                                    
                                    Rectangle()
                                        .foregroundStyle(category.color)
                                        .frame(width: 2, height: 36)
                                    
                                    HStack(alignment: .center) {
                                        
                                        Text(clothTemplate.name)
                                            .font(Font.pretendard(.semibold, size: 17))
                                        Button(action: {
                                            withAnimation {
                                                self.searchMode.toggle()
                                            }
                                        }, label: {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundStyle(.black)
                                        })
                                    }
                                    .padding(.leading, 5)
                                    
                                    Spacer()
                                    
                                    if let additionalButton = self.additionBtn {
                                        additionalButton
                                    }
                                    
                                }
                                .padding(.leading, 18)
                                
                                if searchMode {
                                    // 아이템 목록
                                    ScrollView(.vertical) {
                                        VStack(spacing: 10) {
                                            ForEach(clothSearchVM.presentingClothesData.indices, id: \.self) { index in
                                                ClothSelectedComponent(
                                                    category: clothSearchVM.presentingClothesData[index].category,
                                                    clothName: clothSearchVM.presentingClothesData[index].name,
                                                    clothTag: clothSearchVM.presentingClothesData[index].tag,
                                                    clothThickness: clothSearchVM.presentingClothesData[index].thickness ?? .NORMAL,
                                                    width: 300
                                                )
                                                .onTapGesture {
        //                                            print(clothSearchVM.presentingClothesData[index])
                                                    NotificationCenter.default.post(name: NSNotification.Name("SelectCloth"), object: nil, userInfo: ["clothes": clothSearchVM.presentingClothesData[index], "index": cellIndex])
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 250)
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            HStack(spacing: 0) {
                                                Text("이 키워드로 쇼핑몰에서 찾아보기")
                                                    .font(.pretendard(.semibold, size: 13))
                                                Image(systemName: "chevron.forward")
                                            }
                                            .foregroundStyle(.main)
                                        })
                                    }
                                    .padding(.horizontal)
                                    
                                }
                            }
                        }
                        
                    }
                    // 직접 추가하여 검색하는 경우
                    else {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray, style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 8, dash: [8], dashPhase: 10))
                        if searchMode {
                            VStack {
                                // 상단 타이틀 + x 버튼
                                HStack {
                                    Text("직접 검색하여 추가하기")
                                        .font(.pretendard(.semibold, size: 17))
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            self.searchMode.toggle()
                                        }
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .renderingMode(.template)
                                            .foregroundStyle(.black)
                                            .fontWeight(.semibold)
                                    })
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                // 중간 세그먼트 컨트롤
                                SegmentControlComponent(selectedTab: $clothSearchVM.selectedTab, tabMenus: MyClosetTab.allCases.map{ $0.rawValue }, isMain: false)
                                    
                                // 중간 서치바
                                SearchBarComponent(searchText: $clothSearchVM.searchText, placeHolder: "등록한 옷을 검색하세요", searchAction: { print($0) })
                                    .padding(.horizontal)
                                
                                // 아이템 목록
                                ScrollView(.vertical) {
                                    VStack(spacing: 10) {
                                        ForEach(clothSearchVM.presentingClothesData.indices, id: \.self) { index in
                                            ClothSelectedComponent(
                                                category: clothSearchVM.presentingClothesData[index].category,
                                                clothName: clothSearchVM.presentingClothesData[index].name,
                                                clothTag: clothSearchVM.presentingClothesData[index].tag,
                                                clothThickness: clothSearchVM.presentingClothesData[index].thickness ?? .NORMAL,
                                                width: 300
                                            )
                                            .onTapGesture {
                                                print(clothSearchVM.presentingClothesData[index])
                                                NotificationCenter.default.post(name: NSNotification.Name("SelectCloth"), object: nil, userInfo: ["clothes": clothSearchVM.presentingClothesData[index], "index": cellIndex])
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                .frame(height: 180)
                                .padding(.bottom)
                                
                            }
                        } else {
                            Button(action: {
                                withAnimation {
                                    self.searchMode.toggle()
                                }
                            }, label: {
                                Text("직접 검색하여 추가하기")
                                    .font(.pretendard(.semibold, size: 17))
                                    .foregroundStyle(.gray)
                            })
                        }
                    }
                }
                
            }
    }
}

final class ClothSearchViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    /// 선택된 탭 넘버
    @Published var selectedTab: Int = 0 {
        // 값이 변경됨에 따라 해당 함수가 호출됩니다.
        didSet {
            self.clothesLastPage = -1 // 탭 변경 시엔 항상 -1로 시작
            Task {
                selectedTab != 0
                ? await getMyClothes(by: Category.allCases[selectedTab - 1])
                : await getMyAllClothes()
            }
        }
    }
    /// 검색 텍스트
    @Published var searchText: String = "" {
        didSet { searchClothes(by: self.searchText) }
    }
    /// 화면에 표시되는 Data
    @Published var presentingClothesData: [Clothes] = []
    /// 뒤(뷰모델)에서 관리되는 Data
    private var clothesData: [Clothes] = [] {
        didSet { setPresentingData() }
    }
    /// clothes Data last page
    private var clothesLastPage: Int = -1
    
    init() {
        Task { await getMyAllClothes() }
    }
}

// MARK: Interface Functions
extension ClothSearchViewModel {
}

// MARK: Internal Functions
extension ClothSearchViewModel {
    
    /// 전체 clothes를 가져옵니다 by API
    private func getMyAllClothes() async {
         guard clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothes(lastPage: clothesLastPage) {
             setReceivedData(clothesList: result.ClothesList, lastPage: result.lastPage)
         }
     }
     
    /// 카테고리 값으로 clothes를 가져옵니다 by API
    private func getMyClothes(by category: Category) async {
         guard selectedTab != 0, clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: .init(category: category.rawValue, lastPage: clothesLastPage)) {
             setReceivedData(clothesList: result.clothesList, lastPage: result.lastPage)
         }
     }
    
    /// API에서 받은 Data를 clothesData에 전달합니다.
    private func setReceivedData(clothesList: [Clothes], lastPage: Int) {
        self.clothesLastPage = lastPage
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clothesData = clothesList
        }
    }
    
    /// 새로 받은 clothesData를 화면에 표시합니다
    private func setPresentingData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchText = "" // 새로운 화면이므로 텍스트 필드가 공백
            self.presentingClothesData = self.clothesData
        }
    }
    
    /// 검색 값에 따른 Clothes 표시 데이터를 전달합니다.
    private func searchClothes(by text: String) {
        guard !text.isEmpty else {
            // 텍스트 비면 전체 데이터 표시
            self.presentingClothesData = self.clothesData
            return
        }
        self.presentingClothesData = self.clothesData.filter({ $0.name.contains(text) })
    }
}

#Preview {
    ClothUnSelectedComponent(
        clothTemplate: .init(name: "바지"), cellIndex: 0, searchMode: .constant(true),
        width: 340,
        additionBtn: AnyView(
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "xmark")
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            })
            .padding()
        )
    )
}
