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
    @Published var searchText: String = ""
    @Published var clothesData: [Clothes] = []
    
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
}
