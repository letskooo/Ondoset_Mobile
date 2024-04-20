//
//  BaseResponse.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 사전 정의된 HTTP 응답 메시지의 형태입니다.

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    
    let code: String
    let message: String
    let result: T
}
