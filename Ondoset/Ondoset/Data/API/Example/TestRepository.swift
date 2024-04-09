//
//  TestRepository.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 해당 파일은 예시용 파일입니다.
/// Repository는 APIManager를 통해 API를 호출합니다.
/// 메소드의 반환값 타입으로는 응답 형태의 result 객체의 DTO를 가집니다.

import Foundation

final class TestRepository {
    
    static let shared = TestRepository()
    
    func testRequestPlain() async -> TestResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: TestEndPoint.testRequestPlain)
    }
    
    func testReuestJSON(dto: TestDTO) async -> TestResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: TestEndPoint.testRequestJson(dto: dto))
    }
    
    func testRequestQueryParams(data: TestParamData) async -> TestResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: TestEndPoint.testRequestQueryParams(data: data))
    }
    
    func testRequestPathVariable(data: String) async -> TestResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: TestEndPoint.testRequestPathVariable(data: data))
    }
}
