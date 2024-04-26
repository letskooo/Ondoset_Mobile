//
//  OOTD.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

struct OOTD: Hashable {
    
    let ootdId: Int
    let date: Int
    let lowestTemp: Int
    let highestTemp: Int
    let imageURL: String
}

struct MemberProfile: Hashable {
    
    let memberId: String
    let memberNickname: String
    let profileImage: String
    var ootdList: [OOTD]
    let ootdCount: Int
    let likeCount: Int
    let followingCount: Int    
}

struct PagingOOTD: Hashable {
    
    let lastPage: Int
    let ootdList: [OOTD]
}

struct Following: Hashable {
    
    let memberId: Int
    let nickname: String
    let imageURL: String?
    var isFollowing: Bool
    let ootdCount: Int
}

struct PagingFollowing: Hashable {
    
    let lastPage: Int
    let followingList: [Following]
}
