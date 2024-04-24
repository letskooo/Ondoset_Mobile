//
//  OOTDEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import Foundation
import Alamofire

enum OOTDEndPoint {
    
    case readMyProfile                                         // 내 프로필 조회
    case myProfilePaging(lastPage: Int)                        // 내 프로필 페이징
}

extension OOTDEndPoint: EndPoint {
    
    var baseURL: String {
        
        return "\(Constants.serverURL)/ootd"
    }
    
    var path: String {
        
        switch self {
        case .readMyProfile:
            return "/my-profile"
        case .myProfilePaging:
            return "/my-profile/page"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        case .readMyProfile, .myProfilePaging:
            return .get
        }
    }
    
    var task: APITask {
        
        switch self {
            
        case .readMyProfile:
            return .requestPlain
            
        case let .myProfilePaging(lastPage):
            
            let param = [
                "lastPage": lastPage
            ]
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        default:
            return nil
        }
    }
}
