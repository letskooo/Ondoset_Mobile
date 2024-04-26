//
//  OotdDTO.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import Foundation

struct OOTDDTO: Decodable {
    
    let ootdId: Int
    let date: Int
    let lowestTemp: Int
    let highestTemp: Int
    let imageURL: String
}

extension OOTDDTO {
    func toOOTD() -> OOTD {
        return OOTD(ootdId: self.ootdId, date: self.date, lowestTemp: self.lowestTemp, highestTemp: self.highestTemp, imageURL: "\(Constants.serverURL)/images\(self.imageURL)")
    }
}


// 내 프로필 조회 응답 DTO
struct ReadProfileResponseDTO: Decodable {
    
    let memberId: String
    let nickname: String
    let profileImage: String
    let ootdCount: Int
    let likeCount: Int
    let followingCount: Int
    let lastPage: Int
    let ootdList: [OOTDDTO]
}


extension ReadProfileResponseDTO {
    
    func toMemberProfile() -> MemberProfile {
        
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return MemberProfile(memberId: self.memberId, memberNickname: self.nickname, profileImage: "\(Constants.serverURL)/images\(self.profileImage)", ootdList: ootds, ootdCount: self.ootdCount, likeCount: self.likeCount, followingCount: self.followingCount)
    }
}

// 내 프로필 페이징 응답 DTO
struct MyProfilePagingResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension MyProfilePagingResponseDTO {
    
    func toOOTD() -> [OOTD] {
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}


// 공감한 OOTD 조회 응답 DTO
struct ReadLikeOOTDListResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadLikeOOTDListResponseDTO {
    
    func toOOTD() -> [OOTD] {
     
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}

struct FollowingDTO: Decodable {
    
    let memberId: Int
    let nickname: String
    let imageURL: String?
    let isFollowing: Bool
    let ootdCount: Int
}

extension FollowingDTO {
    
    func toFollowing() -> Following {
        return Following(memberId: self.memberId, nickname: self.nickname, imageURL: self.imageURL, isFollowing: self.isFollowing, ootdCount: self.ootdCount)
    }
}


struct ReadFollowingListResponseDTO: Decodable {
    
    let lastPage: Int
    let followingList: [FollowingDTO]
}

extension ReadFollowingListResponseDTO {
    
    func toFollowing() -> [Following] {
        
        let followingList = self.followingList.map{ $0.toFollowing() }
        
        return followingList
    }
}

// 날씨뷰 조회 요청 DTO
struct ReadWeatherOOTDRequestDTO: Codable {
    
    let weather: String
    let tempRate: String
    let lastPage: Int
}

// 날씨뷰 OOTD 조회 응답 DTO
struct ReadWeatherOOTDListResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadWeatherOOTDListResponseDTO {
    func toOOTD() -> [OOTD] {
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}

// OOTD 등록 DTO
struct AddOOTD {
    
    let departTime: Int
    let arrivalTime: Int
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
    let image: Data
    let wearingList: [String]
}
