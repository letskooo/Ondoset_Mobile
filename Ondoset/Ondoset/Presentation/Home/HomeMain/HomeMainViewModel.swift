//
//  HomeMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class HomeMainViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    // WeatherView Datas
        // WeatherView Current Date
    @Published var homeViewDate: Date = .now
    // BottomView Datas
}

// MARK: Interface Functions
extension HomeMainViewModel {
    func changeDate(with num: Int) {
        self.homeViewDate.
    }
}

// MARK: Internal Functions
extension HomeMainViewModel {
}
