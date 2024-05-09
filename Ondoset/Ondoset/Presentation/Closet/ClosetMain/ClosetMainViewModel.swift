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
    
    private func getMyAllClothes() async {
        guard clothesLastPage != -2 else { return }
        
        if let result = await clothesUseCase.getAllClothes(lastPage: clothesLastPage) {
            
            self.clothesLastPage = result.lastPage
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.clothesData = result.ClothesList
            }
            
        }
    }
    
    private func getMyClothes(by category: Category) async {
        
    }
}
