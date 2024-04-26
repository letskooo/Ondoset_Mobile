//
//  OOTDUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class OOTDUseCase {
    
    static let shared = OOTDUseCase()
    
    let ootdRepository: OOTDRepository = OOTDRepository.shared
    
    // 내 프로필 조회
    func readMyProfile() async -> MemberProfile? {
        
        if let memberProfileDTO = await ootdRepository.readMyProfile() {
            
            return memberProfileDTO.toMemberProfile()
        } else {
            return nil
        }
    }
    
    // 내 프로필 페이징
    func pagingMyProfileOOTD(lastPage: Int) async -> PagingOOTD? {
        
        if let result = await ootdRepository.myProfilePaging(lastPage: lastPage) {
            
            return PagingOOTD(lastPage: result.lastPage, ootdList: result.toOOTD())
        } else {
            return nil
        }
    }
    
    
    // 공감한 OOTD 조회
    func readLikeOOTDList(lastPage: Int) async -> PagingOOTD? {
     
        if let result = await ootdRepository.readLikeOOTDList(lastPage: lastPage) {
            
            return PagingOOTD(lastPage: result.lastPage, ootdList: result.toOOTD())
            
        } else {
            return nil
        }
    }
    
    // 팔로잉 목록 조회
    func readFollowingList(lastPage: Int) async -> PagingFollowing? {
        
        if let result = await ootdRepository.readFollowingList(lastPage: lastPage) {
            
            return PagingFollowing(lastPage: result.lastPage, followingList: result.toFollowing())
        } else {
            return nil
        }
    }
    
    // 날씨뷰 OOTD 조회
    func readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO) async -> PagingOOTD? {
        
        if let result = await ootdRepository.readWeatherOOTDList(data: data) {
            
            return PagingOOTD(lastPage: result.lastPage, ootdList: result.toOOTD())
        } else {
            return nil
        }
    }
}
