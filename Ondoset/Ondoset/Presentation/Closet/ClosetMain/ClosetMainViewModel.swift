//
//  ClosetMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class ClosetMainViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var selectedTab: Int = 0
    @Published var searchText: String = ""
    @Published var clothesData: [Clothes] = []
    
    private var clothesLastPage: Int = -1
        
    init() {
        Task {
            await getMyAllClothes()
        }
    }
    
    func getMyAllClothes() async {
        guard clothesLastPage != -2 else { return }
        
        if let result = await clothesUseCase.getAllClothes(lastPage: clothesLastPage) {
            setReceivedData(clothesList: result.ClothesList, lastPage: result.lastPage)
        }
    }
    
    func getMyClothes(by category: Category) async {
        guard selectedTab != 0, clothesLastPage != -2 else { return }
        
        let categoryName = Category.allCases[self.selectedTab-1].rawValue
        
        if let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: .init(category: categoryName, lastPage: clothesLastPage)) {
            setReceivedData(clothesList: result.clothesList, lastPage: result.lastPage)
        }
    }
}

// MARK: Private Only Function
extension ClosetMainViewModel {
    private func setReceivedData(clothesList: [Clothes], lastPage: Int) {
        self.clothesLastPage = lastPage
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clothesData = clothesList
        }
    }
}
