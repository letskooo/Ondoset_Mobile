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
    let ootdList: [OOTD]
    let ootdCount: Int
    let likeCount: Int
    let followingCount: Int    
}
