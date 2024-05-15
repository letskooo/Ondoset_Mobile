//
//  MemberEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/9/24.
//

import Foundation
import Alamofire

enum MemberEndPoint {
    
    case checkIdDuplicate(username: String)                   // 아이디 중복 체크
    case checkNicknameDuplicate(nickname: String)             // 닉네임 중복 체크
    case signUpMember(signUpDTO: SignUpRequestDTO)            // 회원가입
    case signInMember(signInDTO: SignInRequestDTO)            // 로그인
    case saveOnboarding(onboardingDTO: OnboardingRequestDTO)  // 온보딩 결과 저장
    case withdrawMember                                       // 회원탈퇴
    case updateNickname(nickname: UpdateNicknameRequestDTO)   // 닉네임 수정
    case updateProfileImage(profileImage: Data)            // 프로필 이미지 수정
}

extension MemberEndPoint: EndPoint {
    
    var baseURL: String {
        
        return "\(Constants.serverURL)/member"
    }
    
    var path: String {
        
        switch self {
            
        case.checkIdDuplicate(username: _):
            return "/usable-id"
        case .checkNicknameDuplicate(nickname: _):
            return "/usable-nickname"
        case .signUpMember(signUpDTO: _):
            return "/register"
        case .signInMember(signInDTO: _):
            return "/login"
        case .saveOnboarding(onboardingDTO: _):
            return "/on-boarding"
        case .withdrawMember:
            return "/delete"
        case .updateNickname(nickname: let nickname):
            return "/nickname"
        case .updateProfileImage(profileImage: let profileImage):
            return "/profile-pic"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .checkIdDuplicate, .checkNicknameDuplicate ,.withdrawMember:
            return .get
        case .signUpMember, .signInMember, .saveOnboarding, .updateNickname, .updateProfileImage:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
            
        case let .checkIdDuplicate(username):
            let param = [
                
                "username": username
            ]
            
            return .requestQueryParamsWithoutToken(parameters: param, encoding: URLEncoding.default)
            
        case let .checkNicknameDuplicate(nickname):
            let param = [
                "nickname" : nickname
            ]
            return .requestQueryParamsWithoutToken(parameters: param, encoding: URLEncoding.default)
            
        case .signUpMember(signUpDTO: let dto):
            return .requestJsonWithoutToken(parameters: dto)
            
        case .signInMember(signInDTO: let dto):
            return .requestJsonWithoutToken(parameters: dto)
            
        case .saveOnboarding(onboardingDTO: let dto):
            return .requestJson(parameters: dto)
    
        case .withdrawMember:
            return .requestPlain
            
        case let .updateNickname(nickname):
            return .requestJson(parameters: nickname)
            
        case let .updateProfileImage(profileImage):
            return .uploadImage(image: profileImage)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .signUpMember, .signInMember, .saveOnboarding, .updateNickname:
            return ["Content-Type": "application/json"]
        case .updateProfileImage:
            return ["Content-Type": "multipart/form-data"]
        default:
            return nil
        }
    }
}
