//
//  AddCoordiPlanViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/8/24.
//

import Foundation

class AddCoordiRecordViewModel: ObservableObject {
    
    let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    // 카테고리별 옷 전체 조회
    func getAllClothesByCategory(category: Category, lastPage: Int) async {
        
        let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: GetAllClothesByCategoryRequestDTO(category: category.rawValue, lastPage: lastPage))
        
        print("카테고리별 전체 조회: \(result)")
    }
}
