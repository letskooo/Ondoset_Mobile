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
    
    // 추천뷰 OOTD 조회
    func getRecommendOOTDList(lastPage: Int) async -> PagingOOTD? {
        
        if let result = await ootdRepository.getRecommendOOTDList(lastPage: lastPage) {
            
            return PagingOOTD(lastPage: result.lastPage, ootdList: result.toOOTD())
            
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
    
    // 개별 OOTD 조회
    func getOOTD(ootdId: Int) async -> OOTDItem? {
     
        if let ootdItemDTO = await ootdRepository.getOOTD(ootdId: ootdId) {
            
            return ootdItemDTO.toOOTDItem()
        } else {
            return nil
        }
    }
    
    // 타인 계정 팔로우
    func followOther(followOtherDTO: FollowOtherRequestDTO) async -> Bool {
        
        if let result = await ootdRepository.followOther(followOtherDTO: followOtherDTO) {
            
            return true
            
        } else {
            return false
        }
    }
    
    // 타인 계정 팔로우 취소
    func cancelFollowOther(memberId: Int) async -> Bool {
        
        if let result = await ootdRepository.cancelFollowOther(memberId: memberId) {
            
            return true
        } else {
            return false
        }
    }
    
    // OOTD 공감
    func likeOOTD(likeOOTDDTO: LikeOOTDRequestDTO) async -> Bool {
        
        if let result = await ootdRepository.likeOOTD(likeOOTDDTO: likeOOTDDTO) {
            return true
        } else {
            return false
        }
    }
    
    // 타인 계정 팔로우 취소
    func cancelLikeOOTD(ootdId: Int) async -> Bool {
        if let result = await ootdRepository.cancelLikeOOTD(ootdId: ootdId) {
            return true
        } else {
            return false
        }
    }
    
    // OOTD 등록될 날씨 미리보기
    func getOOTDWeather(data: GetOOTDWeatherRequestDTO) async -> GetOOTDWeatherResponseDTO? {
        
        if let result = await ootdRepository.getOOTDWeather(data: data) {
            
            print("====OOTDUseCase======")
            print(result.weather)
            print(result.lowestTemp)
            print(result.highestTemp)
            
            return result
        } else {
            return nil
        }
    }
    
    // OOTD 등록
    func registerOOTD(data: PostOOTDRequestDTO) async -> Bool {
        
        if let result = await ootdRepository.postOOTD(data: data) {
            
            return true
        } else {
            return false
        }
    }
    
    // OOTD 기능 제한 확인
    func getBanPeriod() async -> Int? {
        
        if let result = await ootdRepository.getBanPeriod() {
            
            return result.banPeriod
            
        } else {
            
            return nil
        }
    }
    
    // OOTD 수정용 조회
    func getOOTDforPut(ootdId: Int) async -> GetOOTDforPut? {
        
        if let result = await ootdRepository.getOOTDforPut(ootdId: ootdId) {
            
            return result.toGetOOTDforPut()
            
        } else {
            return nil
        }
    }
    
    // OOTD 수정
    func putOOTD(ootdId: Int, putOOTDDTO: PutOOTDRequestDTO) async -> Bool {
        
        if let result = await ootdRepository.putOOTD(ootdId: ootdId, putOOTDDTO: putOOTDDTO) {
            
            return true
        } else {
            return false
        }
    }
    
    // OOTD 삭제
    func deleteOOTD(ootdId: Int) async -> Bool? {
        
        if let result = await ootdRepository.deleteOOTD(ootdId: ootdId) {
            
            return true
        } else {
            return nil
        }
    }
    
    // 타인 프로필 및 ootd 목록 조회
    func getOtherProfile(memberId: Int, lastPage: Int) async -> OtherProfile? {
        
        if let result = await ootdRepository.getOtherProfile(memberId: memberId, lastPage: lastPage) {
            
            return result.toOtherProfile()
            
        } else {
            return nil
        }
    }
    
    // OOTD 신고
    func reportOOTD(reportOOTDDTO: ReportOOTDRequestDTO) async -> Bool? {
        
        if let result = await ootdRepository.reportOOTD(reportOOTDDTO: reportOOTDDTO) {
            
            return true
            
        } else {
            
            return nil
        }
    }
    
    // 팔로잉 목록 검색
    func searchFollowingList(search: String, lastPage: Int) async -> PagingFollowing? {
        
        if let result = await ootdRepository.searchFollowingList(search: search, lastPage: lastPage) {
            
            return PagingFollowing(lastPage: result.lastPage, followingList: result.toFollowing())
            
        } else {
            
            return nil
        }
    }
}
