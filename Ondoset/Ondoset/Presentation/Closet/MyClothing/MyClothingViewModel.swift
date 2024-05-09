//
//  MyClothingViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/9/24.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

final class MyClothingViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var myClothing: Clothes? = nil
    @Published var myClothigName: String = ""
    @Published var myClothingCategory: Category? = nil
    @Published var myClothingImage: PhotosPickerItem? = nil {
        didSet {
            Task {
                if let data = try? await myClothingImage?.loadTransferable(type: Data.self) {
                    self.setImageData(with: data)
                }
            }
        }
    }
    @Published var myClothingImageData: Data? = nil
    @Published var detailedTagList: [(Int, String)] = []
    @Published var myClothingDetailedTag: (Int, String) = (-1, "")
    @Published var myClothingThickness: Thickness? = nil
    @Published var saveAvailable: Bool = true
    
    init(myClothing: Clothes?) {
        self.myClothing = myClothing
    }
    
}

// MARK: Interface Functions
extension MyClothingViewModel {
}

// MARK: Internal Functions
extension MyClothingViewModel {
    /// 선택한 이미지 데이터를 세팅합니다
    private func setImageData(with data: Data) {
        DispatchQueue.main.async {
            self.myClothingImageData = data
        }
    }
}
