//
//  ClosetMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class ClosetMainViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var selectedTab: Int = 0 {
        // 값이 변경됨에 따라 해당 함수가 호출됩니다.
        didSet {
            self.clothesLastPage = -1
            Task {
                if selectedTab != 0 {
                    await getMyClothes(by: Category.allCases[selectedTab - 1])
                }
                else {
                    await getMyAllClothes()
                }
            }
        }
    }
    @Published var searchText: String = "" {
        didSet { searchClothes(by: self.searchText) }
    }
    /// 화면에 표시되는 Data
    @Published var presentingClothesData: [Clothes] = []
    /// 뒤(뷰모델)에서 관리되는 Data
    private var clothesData: [Clothes] = [] {
        didSet { setNewPresenting() }
    }
    
    private var clothesLastPage: Int = -1
        
    init() {
        Task {
            await getMyAllClothes()
        }
    }
}

// MARK: Interface Functions
extension ClosetMainViewModel {
}

// MARK: Internal Functions
extension ClosetMainViewModel {
    
    private func getMyAllClothes() async {
         guard clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothes(lastPage: clothesLastPage) {
             setReceivedData(clothesList: result.ClothesList, lastPage: result.lastPage)
         }
     }
     
    private func getMyClothes(by category: Category) async {
         guard selectedTab != 0, clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: .init(category: category.rawValue, lastPage: clothesLastPage)) {
             setReceivedData(clothesList: result.clothesList, lastPage: result.lastPage)
         }
     }
    
    private func setReceivedData(clothesList: [Clothes], lastPage: Int) {
        self.clothesLastPage = lastPage
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clothesData = clothesList
        }
    }
    
    private func setNewPresenting() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchText = ""
            self.presentingClothesData = self.clothesData
        }
    }
    
    private func searchClothes(by text: String) {
        guard !text.isEmpty else { return }
        self.presentingClothesData = self.clothesData.filter({ $0.name.contains(text) })
    }
}
