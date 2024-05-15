//
//  CoordiEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import Foundation
import Alamofire

enum CoordiEndPoint {
    
    case getCoordiRecord(data: GetCoordiRecordRequestDTO)               // 코디 기록/계획 조회
    case setSatisfaction(coordiId: Int, data: SetSatisfactionRequestDTO)                                 // 만족도 등록/수정
    case setCoordiTime(coordiId: Int, data: SetCoordiTimeRequestDTO)    // 외출시간 등록/수정
    case putCoordi(coordiId: Int, data: PutCoordiRequestDTO)            // 코디 수정
    case deleteCoordi(coordiId: Int)                                    // 코디 삭제
    case setCoordiImage(coordiId: Int, image: Data)                     // 코디 이미지 등록/수정
    case setCoordiPlan(addType: String, data: SetCoordiPlanRequestDTO)                   // 코디 계획 등록
    case setCoordiRecord(data: SetCoordiRecordRequestDTO)               // 과거 코디 기록 등록
    case getSatisfactionPred(data: GetSatisfactionPredRequestDTO)       // 만족도 예측
    
    case getDailyCoordi(data: GetDailyCoordiRequestDTO)                 // 코디 하루 조회
}

extension CoordiEndPoint: EndPoint {
    
    var baseURL: String {
        
        return "\(Constants.serverURL)/coordi"
    }
    
    var path: String {
        
        switch self {
            
        case .getCoordiRecord:
            return ""
            
        case .setSatisfaction(coordiId: let coordiId, data: let data):
            return "/satisfaction/\(coordiId)"
        case .setCoordiTime(coordiId: let coordiId, data: let data):
            return "/out-time/\(coordiId)"
        case .putCoordi(coordiId: let coordiId, data: let data):
            return "/\(coordiId)"
        case .deleteCoordi(coordiId: let coordiId):
            return "/\(coordiId)"
        case .setCoordiImage(coordiId: let coordiId, image: let image):
            return "/image/\(coordiId)"
        case .setCoordiPlan(let addType, data: let data):
            return "/plan/\(addType)"
        case .setCoordiRecord(data: let data):
            return "/"
        case .getSatisfactionPred(data: let data):
            return "/satisfaction-pred"
            
        case .getDailyCoordi(data: let data):
            return ""
        }
        
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        case .getCoordiRecord, .getDailyCoordi:
            return .get
        case .setSatisfaction, .setCoordiImage, .putCoordi, .setCoordiTime:
            return .put
        case .getSatisfactionPred, .setCoordiRecord, .setCoordiPlan:
            return .post
        case .deleteCoordi:
            return .delete
        }
    }
    
    var task: APITask {
        
        switch self {
            
        case let .getCoordiRecord(data):
            
            let params = [
                
                "year": data.year,
                "month": data.month
            ]
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case let .getDailyCoordi(data):
            
            let params = [
                
                "year": data.year,
                "month": data.month,
                "day": data.day
            ]
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case .setSatisfaction(coordiId: let coordiId, data: let data):
            
            return .requestJson(parameters: data)
            
        case .setCoordiTime(coordiId: let coordiId, data: let data):
            return .requestJson(parameters: data)
            
        case .putCoordi(coordiId: let coordiId, data: let data):
            return .requestJson(parameters: data)
            
        case .deleteCoordi(coordiId: let coordiId):
            return .requestPathVariable
            
        case .setCoordiImage(coordiId: let coordiId, image: let image):
            return .uploadImage(image: image)
            
        case .setCoordiPlan(addType: let addType, data: let data):
            return .requestJson(parameters: data)
            
        case .setCoordiRecord(data: let data):
            return .requestJson(parameters: data)
            
        case .getSatisfactionPred(data: let data):
            return .requestJson(parameters: data)
            
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .setCoordiTime, .putCoordi, .setCoordiPlan, .setCoordiRecord, .getSatisfactionPred, .setSatisfaction:
            return ["Content-Type": "application/json"]
            
        case .setCoordiImage:
            return ["Content-Type": "multipart/form-data"]
            
        default:
            return nil
            
        }
    }
}
