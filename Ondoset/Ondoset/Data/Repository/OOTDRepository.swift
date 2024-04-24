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
}
