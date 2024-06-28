//
//  MemberDTO.swift
//  Ondoset
//
//  Created by KoSungmin on 4/14/24.
//

import Foundation

struct TokenReissuanceRequestDTO: Encodable {
    
    let accessToken: String
    let refreshToken: String
}

// AccessToken 재발급 응답 DTO
struct TokenReissuanceResponseDTO: Decodable {
    
    let accessToken: String
    let refreshToken: String
}

// 아이디 중복 체크 응답 DTO
struct DuplicateCheckResponseDTO: Decodable {
    
    let usable: Bool
    let msg: String
}

// 회원가입 DTO
struct SignUpRequestDTO: Codable {
    
    let username: String
    let password: String
    let nickname: String
}

// 로그인 요청 DTO
struct SignInRequestDTO: Codable {
    
    let username: String
    let password: String
}

// 로그인 응답 DTO
struct SignInResponseDTO: Decodable {
    
    let isFirst: Bool
    let accessToken: String
    let refreshToken: String
    let memberId: Int
}

// 온보딩 요청 DTO
struct OnboardingRequestDTO: Encodable {
    
    let answer: [Int]
}

// 닉네임 수정 요청 DTO
struct UpdateNicknameRequestDTO: Encodable {
    
    let nickname: String
}
