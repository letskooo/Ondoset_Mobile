//
//  MemberEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/9/24.
//

import Foundation
import Alamofire

enum MemberEndPoint {
    
    case checkIdDuplicate(memberId: String)                   // 아이디 중복 체크
    case checkNicknameDuplicate(nickname: String)             // 닉네임 중복 체크
    case signUpMember(signUpDTO: SignUpRequestDTO)            // 회원가입
    case signInMember(signInDTO: SignInRequestDTO)            // 로그인
    case saveOnboarding(onboardingDTO: OnboardingRequestDTO)
}

extension MemberEndPoint: EndPoint {
    
    var baseURL: String {
        
        /// 학과 서버
        //return "\(serverURL)/member"
        
        /// EC2
        return "\(ec2URL)/member"
    }
    
    var path: String {
        
        switch self {
            
        case.checkIdDuplicate(memberId: _):
            return "/usable-id"
        case .checkNicknameDuplicate(nickname: _):
            return "/usable-nickname"
        case .signUpMember(signUpDTO: _):
            return "/register"
        case .signInMember(signInDTO: _):
            return "/login"
        case .saveOnboarding(onboardingDTO: _):
            return "/on-boarding"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .checkIdDuplicate, .checkNicknameDuplicate:
            return .get
        case .signUpMember, .signInMember, .saveOnboarding:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
            
        case let .checkIdDuplicate(memberId):
            let param = [
                
                "memberId": memberId
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
            return .requsetJson(parameters: dto)
    
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .signUpMember, .signInMember, .saveOnboarding:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
}
