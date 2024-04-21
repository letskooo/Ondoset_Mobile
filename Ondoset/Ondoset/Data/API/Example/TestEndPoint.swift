//
//  TestEndPoint.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 해당 파일은 예시용 파일입니다.
/// 해당 도메인에서 호출하는 API를 선언하고 정의합니다.

import Foundation
import Alamofire

enum TestEndPoint {
    
    case testRequestPlain
    case testRequestJson(dto: TestDTO)
    case testRequestQueryParams(data: TestParamData)
    case testRequestPathVariable(data: String)
}

extension TestEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(serverURL)/test"
    }
    
    var path: String {
        switch self {
        case .testRequestPlain, .testRequestJson, .testRequestQueryParams:
            return ""
        case .testRequestPathVariable(data: let data):
            return "/\(data)"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .testRequestPlain, .testRequestQueryParams, .testRequestPathVariable:
            return .get
        case .testRequestJson:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case .testRequestPlain:
            return .requestPlain
        case .testRequestJson(dto: let dto):
            return .requsetJson(parameters: dto)
        case let .testRequestQueryParams(data):
            let params = [
                "name" : data.name,
                "email" : data.email
            ]
            return .requestQueryParams(parameters: params, encoding: URLEncoding.default)
            
        case .testRequestPathVariable(data: let data):
            return .requestPathVariable
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .testRequestJson:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
}
