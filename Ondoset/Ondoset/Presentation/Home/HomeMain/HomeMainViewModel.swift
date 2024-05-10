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
    @Published var weatherViewDate: Date = .now
    // BottomView Datas
}
