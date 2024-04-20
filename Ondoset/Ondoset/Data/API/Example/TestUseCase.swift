//
//  TestUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 해당 파일은 예시용 파일입니다.
/// 로직 처리를 담당하는 UseCase 클래스입니다.
/// UseCase는 Repository를 활용해 로직을 처리합니다.
/// ViewModel에서 호출될 메소드를 정의하고 Combine을 활용해 Publisher를 반환타입으로 가질 수 있습니다.

//import Foundation
//import Combine
//
//class TestUseCase {
//    
//    static let shared = TestUseCase()
//    
//    let testRepository: TestRepository = TestRepository.shared
//    
//    /// 에러 처리를 EndPoint, Repository, UseCase 선에서 끝낼 것이기 때문에
//    /// ViewModel까지 Error를 가져갈 필요가 없다고 판단해서 AnyPublisher<Data, Never>의 형태로 반환.
//    /// 따라서 ViewModel에서는 데이터에 대한 처리만 해주면 됩니다.
//    /// 물론 필요와 상황에 따라서 ViewModel에서 에러 처리를 해야 한다면 Never가 아니라 Error로 반환해서
//    /// ViewModel에서 에러 처리를 해도 됩니다.
//    
//    // 요청 데이터가 없는 단순한 요청
//    func testRequestPlain() async -> AnyPublisher<TestResponseDTO, Never> {
//        
//        let result = await testRepository.testRequestPlain()
//        
//        return Just(result)
//            .compactMap{ $0 }
//            .eraseToAnyPublisher()
//    }
//    
//    // request body에 json 데이터
//    func testRequestJSON() async -> AnyPublisher<TestResponseDTO, Never> {
//        
//        let result = await testRepository.testReuestJSON(dto: TestDTO(name: "korea", email: "123@naver.com"))
//        
//        return Just(result)
//            .compactMap{ $0 }
//            .eraseToAnyPublisher()
//    }
//    
//    
//    // 쿼리 파라미터
//    func testRequestQueryParams() async -> TestResponseDTO? {
//        
//        let result = await testRepository.testRequestQueryParams(data: TestParamData(name: "KKKKK", email: "kodele9@test.com"))
//        
//        // 옵셔널 값임
//        print(result?.name)
//        print(result?.age)
//        return result
//    }
//    
//    // PathVariable
//    func testRequestPathVariable() async -> TestResponseDTO? {
//        
//        let result = await testRepository.testRequestPathVariable(data: "test2323")
//    
//        return result
//    }
//}
