//
//  ClosetMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class ClosetMainViewModel: ObservableObject {
    
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
extension ClosetMainViewModel {
}

// MARK: Internal Functions
extension ClosetMainViewModel {
    
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
