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
    case readLikeOOTDList(lastPage: Int)                       // 공감한 OOTD 조회
    case readFollowingList(lastPage: Int)                      // 팔로잉 목록 조회
    
    case readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO)  // OOTD 날씨뷰 조회
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
        case .readLikeOOTDList:
            return "/like-list"
        case .readFollowingList:
            return "/follow-list"
        case .readWeatherOOTDList:
            return "/weather"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        case .readMyProfile, .myProfilePaging, .readLikeOOTDList, .readFollowingList, .readWeatherOOTDList:
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
            
        case let .readLikeOOTDList(lastPage):
            
            let param = [
                "lastPage": lastPage
            ]
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            
        case let .readFollowingList(lastPage):
            
            let param = [
                
                "lastPage": lastPage
                
            ]
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            
        case let .readWeatherOOTDList(data):
            
            let params = [
                "weather": data.weather,
                "tempRate": data.tempRate,
                "lastPage": data.lastPage
            ] as [String : Any]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        default:
            return nil
        }
    }
}
