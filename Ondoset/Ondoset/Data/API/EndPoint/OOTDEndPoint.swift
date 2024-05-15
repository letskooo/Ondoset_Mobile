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
    
    case getRecommendOOTDList(lastPage: Int)                   // OOTD 추천뷰 조회
    case readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO)  // OOTD 날씨뷰 조회
    
    case getOOTDWeather(data: GetOOTDWeatherRequestDTO)        // OOTD 등록될 날씨 미리보기

    case postOOTD(data: PostOOTDRequestDTO)                    // OOTD 등록
    
    case getBanPeriod                                          // OOTD 기능 제한 확인
    
    case getOOTDforPut(ootdId: Int)                         // OOTD 수정용 조회
    
    case putOOTD(ootdId: Int, data: PutOOTDRequestDTO)         // OOTD 수정
    
    case deleteOOTD(ootdId: Int)                               // OOTD 삭제
    
    case getOtherProfile(memberId: Int, lastPage: Int)         // 타인 프로필 및 ootd 목록 조회
    
    case reportOOTD(reportOOTDDTO: ReportOOTDRequestDTO)       // OOTD 신고
    
    case searchFollowingList(search: String, lastPage: Int)    // 팔로잉 목록 검색
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
        case .postOOTD:
            return "/"
        case .getRecommendOOTDList(lastPage: let lastPage):
            return "/latest"
        case .getBanPeriod:
            return "/ban-period"
        case .getOOTDforPut(ootdId: let ootdId):
            return "/modify-page/\(ootdId)"
        case .putOOTD(ootdId: let ootdId, data: let data):
            return "/\(ootdId)"
        case .deleteOOTD(ootdId: let ootdId):
            return "/\(ootdId)"
        case .getOtherProfile:
            return "/profile"
        case .reportOOTD:
            return "/report"
        case .searchFollowingList:
            return "/follow-list"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        case .readMyProfile, .myProfilePaging, .readLikeOOTDList, .readFollowingList,  .readWeatherOOTDList, .getOOTD, .getOOTDWeather, .getRecommendOOTDList, .getBanPeriod, .getOOTDforPut, .getOtherProfile, .searchFollowingList:
            return .get
        case .followOther, .likeOOTD, .postOOTD, .reportOOTD:
            return .post
        case .cancelFollowOther, .cancelLikeOOTD, .putOOTD:
            return .put
        case .deleteOOTD:
            return .delete
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
            
            let body = [
                "region": data.region, "departTime": data.departTime, "arrivalTime": data.arrivalTime, "weather": data.weather, "lowestTemp": data.lowestTemp, "highestTemp": data.highestTemp, "wearingList": data.wearingList] as [String : Any]
            
            return .uploadImagesWithData(image: data.image, data: body)
            
        case let .getRecommendOOTDList(lastPage):
            
            let param = [
                
                "lastPage": lastPage
            ]
            
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            
        case .getBanPeriod:
            
            return .requestPlain
            
        case .getOOTDforPut(ootdId: let ootdId):
            
            return .requestPathVariable
            
        case .putOOTD(ootdId: let ootdId, data: let data):
            
            let body = [
                "region": data.region, "departTime": data.departTime, "arrivalTime": data.arrivalTime, "weather": data.weather, "lowestTemp": data.lowestTemp, "highestTemp": data.highestTemp, "wearingList": data.wearingList] as [String : Any]
            
            if let image = data.image {
                
                return .uploadImagesWithData(image: data.image, data: body)
                
            } else {
                
                return .uploadImagesWithData(image: nil, data: body)
            }
            
        case .deleteOOTD(ootdId: let ootdId):
            
            return .requestPlain
            
        case .getOtherProfile(memberId: let memberId, lastPage: let lastPage):
            
            let params = [
                
                "memberId": memberId,
                "lastPage": lastPage
            ]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case let .reportOOTD(reportOOTDDTO):
            
            return .requestJson(parameters: reportOOTDDTO)
            
        case .searchFollowingList(search: let search, lastPage: let lastPage):
            
            let params = [
            
                "search": search,
                "lastPage": lastPage
            ] as [String : Any]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .followOther, .likeOOTD, .reportOOTD:
            return ["Content-Type": "application/json"]
            
        case .postOOTD, .putOOTD:
            return ["Content-Type": "multipart/form-data"]
            
        default:
            return nil
        }
    }
}
