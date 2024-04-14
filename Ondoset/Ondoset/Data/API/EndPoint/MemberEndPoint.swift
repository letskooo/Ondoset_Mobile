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
//    case checkNicknameDuplicate(nickname: String)       // 닉네임 중복 체크
}

extension MemberEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(testServerURL)/member"
    }
    
    var path: String {
        
        switch self {
            
        case.checkIdDuplicate(memberId: _):
            return "/usable-id"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .checkIdDuplicate:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
            
        case let .checkIdDuplicate(memberId):
            let param = [
                
                "memberId": memberId
            ]
            
            return .requestQueryParamsWithoutToken(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
        default:
            return nil
        }
    }
}
