//
//  AICoordiRecommendViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/12/24.
//

import Foundation

final class AICoordiRecommendViewModel: ObservableObject {
    @Published var clothesData: [ClothTemplate] = ClothTemplate.mockData()
}

// MARK: Interface Functions
extension AICoordiRecommendViewModel {
    func deleteClothes(with idx: Int) {
        self.clothesData.remove(at: idx)
    }
}
