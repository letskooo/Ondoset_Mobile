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

// 내 프로필 조회 응답 DTO
struct ReadProfileResponseDTO: Decodable {
    
    let nickname: String
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
