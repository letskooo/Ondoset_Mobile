//
//  OOTDRepository.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

final class OOTDRepository {
    
    static let shared = OOTDRepository()
    
    // 내 프로필 조회
    func readMyProfile() async -> ReadProfileResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.readMyProfile)
    }
    
    // 내 프로필 페이징
    func myProfilePaging(lastPage: Int) async -> MyProfilePagingResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.myProfilePaging(lastPage: lastPage))
    }
    
    // 공감한 OOTD 조회
    func readLikeOOTDList(lastPage: Int) async -> ReadLikeOOTDListResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.readLikeOOTDList(lastPage: lastPage))
    }
    
    // 팔로잉 목록 조회
    func readFollowingList(lastPage: Int) async -> ReadFollowingListResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.readFollowingList(lastPage: lastPage))
    }
    
    // 날씨뷰 OOTD 조회
    func readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO) async ->  ReadWeatherOOTDListResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.readWeatherOOTDList(data: data))
    }
}
