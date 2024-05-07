//
//  APITask.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// APITask 정의 파일입니다.
/// 이번 프로젝트에서 서버에 보낼 수 있는 일곱가지 요청 유형을 정의했습니다.

import Foundation
import Alamofire

public enum APITask {
    
    /// 요청 데이터 없는 단순한 요청
    case requestPlain
    
    // let parameters = ["userId": "1", "token": "abc123"]
    // var params: Parameters = [ "query" : query ]

    /// RequestBody에 JSON 데이터로 요청
    case requestJson(parameters: Encodable)
    
    /// RequestBody에 JSON 데이터로 요청(토큰X)
    case requestJsonWithoutToken(parameters: Encodable)
    
    /// 쿼리 파라미터 요청(Query Parameter)
    case requestQueryParams(parameters: Parameters, encoding: ParameterEncoding)
    
    /// 쿼리 파라미터 요청(토큰X)
    case requestQueryParamsWithoutToken(parameters: Parameters, encoding: ParameterEncoding)
    
    /// PathVariable 요청
    case requestPathVariable
    
    /// 이미지 업로드
    case uploadImage(image: Data)
    
    /// form 데이터 요청
    case uploadImagesWithData(image: Data?, data: [String: Any])
}
