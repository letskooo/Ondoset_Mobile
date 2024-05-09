//
//  MyClothingViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/9/24.
//

import Foundation

final class MyClothingViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var myClothing: Clothes? = nil
    @Published var myClothigName: String = ""
    @Published var myClothingCategory: Category? = nil
    @Published var detailedTagList: [(Int, String)] = []
    @Published var myClothingDetailedTag: (Int, String) = (-1, "")
    @Published var myClothingThickness: Thickness? = nil
    @Published var saveAvailable: Bool = true
    
}

// MARK: Interface Functions
extension MyClothingViewModel {
}

// MARK: Internal Functions
extension MyClothingViewModel {
}
