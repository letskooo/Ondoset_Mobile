//
//  ClothesEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import Foundation
import Alamofire

enum ClothesEndPoint {
    
    // 날씨 예보 및 홈 카드뷰 조회
    case getHomeInfo(dto: GetHomeInfoRequestDTO)
    
    // 옷 검색 (추천 태그)
    case searchClothByTag(dto: SearchClothByTagRequestDTO)
    
    // 옷 전체 조회
    case getAllClothes(lastPage: Int)
    
    // 카테고리별 옷 전체 조회
    case getAllClothesByCategory(dto: GetAllClothesByCategoryRequestDTO)
    
    // 옷 검색 (검색어)
    case searchClothByKeyword(dto: SearchClothByKeywordRequestDTO)
    
    // 세부 태그 목록 조회
    case getTagList
    
    // 옷 등록
    case postCloth(dto: PostClothRequestDTO)
    
    // 옷 수정
    case putCloth(dto: PutClothRequestDTO)
    
    // 옷 수정(이미지 포함X)
    case patchCloth(dto: PatchClothRequestDTO)
    
    // 옷 삭제
    case deleteCloth(clothesId: Int)
    
}

extension ClothesEndPoint: EndPoint {
    
    var baseURL: String {
        
        return "\(Constants.serverURL)/clothes"
    }
    
    var path: String {
        
        switch self {
 
        case .getHomeInfo:
            return "/home"
        case .searchClothByTag:
            return ""
        case .getAllClothes:
            return "/all"
        case .getAllClothesByCategory:
            return "/all"
        case .searchClothByKeyword:
            return "/search"
        case .getTagList:
            return "/tag"
        case .postCloth:
            return "/"
        case .putCloth(dto: let dto):
            return "/\(dto.clothesId)"
        case .patchCloth(dto: let dto):
            return "/\(dto.clothesId)"
        case .deleteCloth(clothesId: let clothesId):
            return "/\(clothesId)"
        }
    }
    
    var method: HTTPMethod {
        
        
        switch self {
            
        case .getHomeInfo, .searchClothByTag, .getAllClothes, .getAllClothesByCategory, .searchClothByKeyword, .getTagList:
            return .get
        case .postCloth:
            return .post
        case .putCloth:
            return .put
        case .patchCloth:
            return .patch
        case .deleteCloth:
            return .delete
            
        }
    }
    
    var task: APITask {
        
        switch self {
            
        case .getHomeInfo(dto: let dto):
            
            let params = [
                
                "date": dto.date,
                "lat": dto.lat,
                "lon": dto.lon
            ] as [String : Any]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case .searchClothByTag(dto: let dto):
            
            if let thickness = dto.thickness {
                
                let params = [
                    
                    "thickness": dto.thickness,
                    "tagId": dto.tagId
                ] as [String : Any]
             
                return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
                
            } else {
                
                let param = [
                    
                    "tagId": dto.tagId
                    
                ]
                
                return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            }
            
        case .getAllClothes(lastPage: let lastPage):
            
            let param = [
                "lastPage": lastPage
            ]
            
            return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            
            
        case .getAllClothesByCategory(dto: let dto):
            
            let params = [
                
                "category": dto.category,
                "lastPage" : dto.lastPage
            ] as [String : Any]
            
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
            
        case .searchClothByKeyword(dto: let dto):
            
            if let category = dto.category {
                
                let params = [
                    
                    "category": category,
                    "clothesName": dto.clothesName
                ]
                
                return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
                
            } else {
                
                let param = [
                
                    "clothesName": dto.clothesName
                ]
                
                return .requestQueryParams(parameters: param, encoding: URLEncoding.default)
            }
            
        case .getTagList:
            
            return .requestPlain
            
        case .postCloth(dto: let dto):
            
            let body = ["name": dto.name, "tagId": dto.tagId, "thickness": dto.thickness ?? nil] as [String : Any]
            
            return .uploadImagesWithData(image: dto.image ?? nil, data: body)
            
        case .putCloth(dto: let dto):
            
            let body = ["name": dto.name, "tagId": dto.tagId, "thickness": dto.thickness ?? nil] as [String : Any]
            
            return .uploadImagesWithData(image: dto.image, data: body)
            
        case .patchCloth(dto: let dto):
            
            let body = ["name": dto.name, "tagId": dto.tagId, "thickness": dto.thickness ?? nil] as [String : Any]
            
            return .uploadImagesWithData(image: nil, data: body)
            
        case .deleteCloth(clothesId: let clothesId):
            return .requestPathVariable
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .postCloth, .putCloth, .patchCloth:
            
            return ["Content-Type": "multipart/form-data"]
            
        default:
            return nil
            
        }
    }
}
