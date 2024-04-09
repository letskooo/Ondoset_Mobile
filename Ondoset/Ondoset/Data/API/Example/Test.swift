//
//  Test.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 해당 파일은 예시용 파일입니다.
/// 이곳에 도메인별 DTO를 선언합니다.
/// 필요에 의하여 같은 도메인이어도 Swift 파일을 분할하여 선언할 수도 있습니다.

import Foundation

struct TestDTO: Codable {
    
    var name: String
    var email: String
}

struct TestParamData {
    
    var name: String
    var email: String
}

struct TestResponseDTO: Decodable {
    
    var name: String
    var age: Int
}
