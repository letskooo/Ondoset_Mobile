//
//  AddCoordiPlanViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/8/24.
//

import Foundation

class AddCoordiRecordViewModel: ObservableObject {
    
    let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    let coordiUseCase: CoordiUseCase = CoordiUseCase.shared
    
    // 조회되는 옷 목록
    @Published var clothesList: [Clothes] = []
    
    // 코디 등록에 추가되는 옷 리스트
    @Published var coordiClothesList: [Clothes] = []
    
    var getAllClothesLastPage: Int = -1
    var getAllClothesByTopLastPage: Int = -1
    var getAllClothesByBottomLastPage: Int = -1
    var getAllClothesByOuterLastPage: Int = -1
    var getAllClothesByShoeLastPage: Int = -1
    var getAllClothesByAccLastPage: Int = -1
    
    init() {
        Task {
            await getAllClothes(lastPage: getAllClothesLastPage)
        }
    }
    
    // 옷 전체 조회
    func getAllClothes(lastPage: Int) async {
        
        if getAllClothesLastPage != -2 {
            
            if let result = await clothesUseCase.getAllClothes(lastPage: getAllClothesLastPage) {
                
                DispatchQueue.main.async {
                    
                    self.clothesList.removeAll()
                    self.clothesList.append(contentsOf: result.clothesList)
                    
                    // 추후 페이징 처리 보수 필요
//                    self.getAllClothesLastPage = result.lastPage
                }
            }
        }
    }
    
    // 카테고리별 옷 전체 조회
    func getAllClothesByCategory(category: Category, lastPage: Int) async {
        
        if let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: GetAllClothesByCategoryRequestDTO(category: category.rawValue, lastPage: lastPage)) {
            
            print("뷰모델 카테고리 탭 별 옷 조회: \(result)")
            
            DispatchQueue.main.async {
                
                self.clothesList.removeAll()
                self.clothesList.append(contentsOf: result.clothesList)
                
                
                // 추후 페이징 처리 보수 필요
//                switch category {
//                    
//                case .TOP:
//                    self.getAllClothesByTopLastPage = result.lastPage
//                    
//                case .BOTTOM:
//                    self.getAllClothesByBottomLastPage = result.lastPage
//                case .OUTER:
//                    self.getAllClothesByOuterLastPage = result.lastPage
//                case .SHOE:
//                    self.getAllClothesByShoeLastPage = result.lastPage
//                case .ACC:
//                    self.getAllClothesByAccLastPage = result.lastPage
//                }
            }
        }
    }
    
    // 옷 검색(검색어)
    func searchClothByKeyword(category: Category?, clothesName: String) async {
        
        if let result = await clothesUseCase.searchClothByKeyword(searchClothByKeywordDTO: SearchClothByKeywordRequestDTO(category: category?.rawValue, clothesName: clothesName)) {
            
            DispatchQueue.main.async {
                
                self.clothesList.removeAll()
                self.clothesList.append(contentsOf: result)
            }
        }
    }
    
    // 과거 코디 기록 등록
    func setCoordiRecord(lat: Double, lon: Double, region: String, departTime: Int, arrivalTime: Int, clothesList: [Int]) async -> Bool {
        
        if let result = await coordiUseCase.setCoordiRecord(setCoordiRecordDTO: SetCoordiRecordRequestDTO(lat: lat, lon: lon, region: region, departTime: departTime, arrivalTime: arrivalTime, clothesList: clothesList)) {
            
            return true
        } else {
            return false
        }
    }
    
    // 코디 계획 등록
    func setCoordiPlan(date: Int, clothesList: [Int]) async -> Bool {
        
        if let result = await coordiUseCase.setCoordiPlan(addType: "past", setCoordiPlanDTO: SetCoordiPlanRequestDTO(date: date, clothesList: clothesList)) {
            
            return true
            
        } else {
            return false
        }
    }
}
