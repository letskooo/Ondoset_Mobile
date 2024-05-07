//
//  ClothesUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

/// 원래 여기서 에러 처리를 적극적으로 하기 위해 설계되었으나....
/// 현재는 Repository와 역할이 좀 겹치는 감이 있습니다.
/// 추후에 에러 처리를 제대로 하면 좋을 듯합니다.

class ClothesUseCase {
    
    static let shared = ClothesUseCase()
    
    let clothesRepository: ClothesRepository = ClothesRepository.shared
    
    // 날씨 예보 및 홈 카드뷰 조회
    func getHomeInfo(getHomeInfoDTO: GetHomeInfoRequestDTO) async -> HomeInfo? {
        
        guard let result = await clothesRepository.getHomeInfo(getHomeInfoDTO: getHomeInfoDTO) else {
            return nil
        }
        
        return result.toHomeInfo()
    }
    
    // 옷 검색 (추천 태그)
    func searchClothByTag(searchClothByTagDTO: SearchClothByTagRequestDTO) async -> SearchedClothByTag? {
     
        guard let result = await clothesRepository.searchClothByTag(searchClothByTagDTO: searchClothByTagDTO) else { return nil }
        
        return result.toSearchedClothByTag()
    }
    
    // 옷 전체 조회
    func getAllClothes(lastPage: Int) async -> AllClothes? {
        
        guard let result = await clothesRepository.getAllClothes(lastPage: lastPage) else {
            return nil
        }
        
        return result.toAllClothes()
    }
    
    // 카테고리별 옷 전체 조회
    func getAllClothesByCategory(getAllClothesByCategoryDTO: GetAllClothesByCategoryRequestDTO) async -> AllClothByCategory? {
        
        guard let result = await clothesRepository.getAllClothesByCategory(getAllClothesByCategoryDTO: getAllClothesByCategoryDTO) else { return nil }
        
        return result.toAllClothesByCategory()
    }
    
    // 옷 검색 (검색어)
    func searchClothByKeyword(searchClothByKeywordDTO: SearchClothByKeywordRequestDTO) async -> [Clothes]? {
        
        guard let result = await clothesRepository.searchClothByKeyword(searchClothByKeywordDTO: searchClothByKeywordDTO) else { return nil }
        
        return result.toClothesList()
    }
    
    // 세부 태그 목록 조회
    func getTagList() async -> AllTags? {
        
        guard let result = await clothesRepository.getTagList() else { return nil }
        
        return result.toAllTags()
    }
    
    // 옷 등록
    func postCloth(postClothDTO: PostClothRequestDTO) async -> Bool? {
        
        guard let result = await clothesRepository.postCloth(postClothDTO: postClothDTO) else { return nil
        }
        
        return true
    }
    
    // 옷 수정
    func putCloth(putClothDTO: PutClothRequestDTO) async -> Bool? {
        
        guard let result = await clothesRepository.putCloth(putClothDTO: putClothDTO) else {
            return nil
        }
        
        return true
    }
    
    // 옷 수정(이미지 포함)
    func patchCloth(patchClothDTO: PatchClothRequestDTO) async -> Bool? {
        
        guard let result = await clothesRepository.patchCloth(patchClothDTO: patchClothDTO) else {
            return nil
        }
        
        return true
    }
    
    // 옷 삭제(
    func deleteCloth(clothesId: Int) async -> Bool? {
        
        guard let result = await clothesRepository.deleteCloth(clothesId: clothesId) else {
            return nil
        }
        
        return true
    }
}
