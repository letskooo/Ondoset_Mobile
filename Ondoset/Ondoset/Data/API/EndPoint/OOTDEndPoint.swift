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
    case getOOTD(ootdId: Int)                                  // 개별 OOTD 조회
    case followOther(followOtherDTO: FollowOtherRequestDTO)    // 타인 계정 팔로우
    case cancelFollowOther(memberId: Int)                      // 타인 계정 팔로우 취소
    case likeOOTD(likeOOTDDTO: LikeOOTDRequestDTO)             // OOTD 공감
    case cancelLikeOOTD(ootdId: Int)                           // OOTD 공감 취소
    
    case readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO)  // OOTD 날씨뷰 조회
    
    case getOOTDWeather(data: GetOOTDWeatherRequestDTO)        // OOTD 등록될 날씨 미리보기

    case postOOTD(data: PostOOTDRequestDTO)                    // OOTD 등록
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
        case .getOOTD:
            return ""
        case .followOther:
            return "/follow"
        case .cancelFollowOther(memberId: let memberId):
            return "/follow/\(memberId)"
        case .likeOOTD:
            return "/like"
        case .cancelLikeOOTD(ootdId: let ootdId):
            return "/like/\(ootdId)"
        case .getOOTDWeather:
            return "/weather-preview"
        case .postOOTD(data: let data):
            return "/"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        case .readMyProfile, .myProfilePaging, .readLikeOOTDList, .readFollowingList,  .readWeatherOOTDList, .getOOTD, .getOOTDWeather:
            return .get
        case .followOther, .likeOOTD, .postOOTD:
            return .post
        case .cancelFollowOther, .cancelLikeOOTD:
            return .put
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
            
        case let .getOOTD(ootdId):
            
            let param = [
                
                "ootdId": ootdId
            ]
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            
        case let .followOther(followOtherDTO):
            return .requestJson(parameters: followOtherDTO)
            
        case let .cancelFollowOther(memberId):
            return .requestPathVariable
            
        case let .likeOOTD(likeOOTDDTO):
            return .requestJson(parameters: likeOOTDDTO)
            
        case let .cancelLikeOOTD(ootdId):
            return .requestPathVariable
            
        case let .getOOTDWeather(data):
            
            let params = [
                
                "lat": data.lat,
                "lon": data.lon,
                "departTime": data.departTime,
                "arrivalTime": data.arrivalTime
            ] as [String : Any]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case let .postOOTD(data):
            
            let body = ["departTime": data.departTime, "arrivalTime": data.arrivalTime, "weather": data.weather, "lowestTemp": data.lowestTemp, "highestTemp": data.highestTemp, "wearingList": data.wearingList] as [String : Any]
            
            return .uploadImagesWithData(image: data.image, data: body)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .followOther, .likeOOTD:
            return ["Content-Type": "application/json"]
            
        case .postOOTD:
            return ["Content-Type": "multipart/form-data"]
            
        default:
            return nil
        }
    }
}
