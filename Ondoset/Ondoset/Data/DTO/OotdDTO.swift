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

// 내 프로필 페이징 응답 DTO
struct MyProfilePagingResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadProfileResponseDTO {
    
    func toMemberProfile() -> MemberProfile {
        
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return MemberProfile(memberId: self.memberId, memberNickname: self.nickname, profileImage: "\(Constants.serverURL)/images\(self.profileImage)", ootdList: ootds, ootdCount: self.ootdCount, likeCount: self.likeCount, followingCount: self.followingCount)
    }
}
