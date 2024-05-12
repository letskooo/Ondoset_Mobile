//
//  AICoordiRecommendViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/12/24.
//

import Foundation

final class AICoordiRecommendViewModel: ObservableObject {
    @Published var clothesData: [ClothTemplate] = ClothTemplate.mockData()
    @Published var tempIndicator: TempIndicatorType? = nil
    @Published var currentDate: Date  = .now
    @Published var isSaveAvailable: Bool = false
}

// MARK: Interface Functions
extension AICoordiRecommendViewModel {
    func deleteClothes(with idx: Int) {
        self.clothesData.remove(at: idx)
    }
    
//    func addClothes(with )
}
