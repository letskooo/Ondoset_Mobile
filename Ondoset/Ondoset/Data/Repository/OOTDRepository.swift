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
    
    // 개별 OOTD 조회
    func getOOTD(ootdId: Int) async -> GetOOTDResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.getOOTD(ootdId: ootdId))
    }
    
    // 타인 계정 팔로우
    func followOther(followOtherDTO: FollowOtherRequestDTO) async -> FollowOtherResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.followOther(followOtherDTO: followOtherDTO))
    }
    
    // 타인 계정 팔로우 취소
    func cancelFollowOther(memberId: Int) async -> FollowOtherResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.cancelFollowOther(memberId: memberId))
    }
    
    // OOTD 공감
    func likeOOTD(likeOOTDDTO: LikeOOTDRequestDTO) async -> LikeOOTDResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.likeOOTD(likeOOTDDTO: likeOOTDDTO))
    }
    
    // OOTD 공감 취소
    func cancelLikeOOTD(ootdId: Int) async -> LikeOOTDResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.cancelLikeOOTD(ootdId: ootdId))
    }
    
    // OOTD 등록될 날씨 미리보기
    func getOOTDWeather(data: GetOOTDWeatherRequestDTO) async -> GetOOTDWeatherResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.getOOTDWeather(data: data))
    }
    
    // OOTD 등록
    func postOOTD(data: PostOOTDRequestDTO) async -> PostOOTDResponseDTO? {
        
        print(data.weather)
        print(data.image)
        
        return await APIManager.shared.performRequest(endPoint: OOTDEndPoint.postOOTD(data: data))
    }
}
