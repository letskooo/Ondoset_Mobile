//
//  ClothesRepository.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

final class ClothesRepository {
    
    static let shared = ClothesRepository()
    
    // 날씨 예보 및 홈 카드뷰 조회
    func getHomeInfo(getHomeInfoDTO: GetHomeInfoRequestDTO) async -> GetHomeInfoResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.getHomeInfo(dto: getHomeInfoDTO))
    }
    
    // 옷 검색 (추천 태그)
    func searchClothByTag(searchClothByTagDTO: SearchClothByTagRequestDTO) async -> SearchClothByTagResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.searchClothByTag(dto: searchClothByTagDTO))
    }
    
    // 옷 전체 조회
    func getAllClothes(lastPage: Int) async -> GetAllClothesResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.getAllClothes(lastPage: lastPage))
    }
    
    // 카테고리별 옷 전체 조회
    func getAllClothesByCategory(getAllClothesByCategoryDTO: GetAllClothesByCategoryRequestDTO) async -> GetAllClothesByCategoryResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.getAllClothesByCategory(dto: getAllClothesByCategoryDTO))
    }
    
    // 옷 검색 (검색어)
    func searchClothByKeyword(searchClothByKeywordDTO: SearchClothByKeywordRequestDTO) async -> SearchClothByKeywordResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.searchClothByKeyword(dto: searchClothByKeywordDTO))
    }
    
    // 세부 태그 목록 조회
    func getTagList() async -> GetTagListResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.getTagList)
    }
    
    // 옷 등록
    func postCloth(postClothDTO: PostClothRequestDTO) async -> PostClothResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.postCloth(dto: postClothDTO))
    }
    
    // 옷 수정
    func putCloth(putClothDTO: PutClothRequestDTO) async -> PutClothResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.putCloth(dto: putClothDTO))
    }
    
    // 옷 수정(이미지 포함X)
    func patchCloth(patchClothDTO: PatchClothRequestDTO) async -> PatchClothResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.patchCloth(dto: patchClothDTO))
    }
    
    // 옷 삭제
    func deleteCloth(clothesId: Int) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: ClothesEndPoint.deleteCloth(clothesId: clothesId))
    }
}
