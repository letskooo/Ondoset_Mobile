//
//  TestViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/9/24.
//

//import Foundation
//import Combine
//
//class TestViewModel: ObservableObject {
//    
//    let testUseCase: TestUseCase = TestUseCase.shared
//    var cancelables = Set<AnyCancellable>()
//    
//    @Published var plainName: String = "이름이 나타납니다."
//    @Published var plainAge: Int = 1
//    
//    @Published var jsonName: String = "JSON으로 받아온 이름"
//    @Published var jsonAge: Int = 1
//    
//    @Published var queryParamName: String = "쿼리 파라미터로 받아온 이름"
//    @Published var queryParamAge: Int = 1
//    
//    @Published var pathVariableName: String = "PathVariable로 받아온 이름"
//    
////    func testRequestPlain() async {
////        
////        let result = await testUseCase.testRequestPlain()
////        
////        DispatchQueue.main.async {
////            self.plainName = result?.name ?? "값 없음"
////            self.plainAge = result?.age ?? 0
////        }
////
////        print(plainName)
////        print(plainAge)
////    }
//    
//    
//    func testRequestPlain() async {
//        
////        let result = await testUseCase.testRequestPlain()
//        
//        /// result가 AnyPublihser<Data, Never> 타입이기 때문에 에러를 처리할 필요가 없음
//        /// 즉 failure 상황은 고려 및 구현하지 않아도 상관없음.
//        
//        await testUseCase.testRequestPlain()
//            .receive(on: DispatchQueue.main)
//            .sink { data in
//                self.plainName = data.name
//            }
//            .store(in: &cancelables)
//    }
//    
////    func testRequestJSON() async {
////        
////        let result = await testUseCase.testRequestJSON()
////        
////        DispatchQueue.main.async {
////            self.jsonName = result?.name ?? "값 없음"
////            self.jsonAge = result?.age ?? 0
////        }
////        
////        print(jsonName)
////        print(jsonAge)
////    }
//    
//    func testRequestJSON() async {
//        
//        let result = await testUseCase.testRequestJSON()
//        
//        result
//            .receive(on: DispatchQueue.main)
//            .sink { data in self.jsonName = data.name }
//            .store(in: &cancelables)
//    }
//    
//    func testRequestQueryParams() async {
//        
//        let result = await testUseCase.testRequestQueryParams()
//        
//        DispatchQueue.main.async {
//            self.queryParamName = result?.name ?? "값 없음"
//            self.queryParamAge = result?.age ?? 0
//        }
//    }
//    
//    func testRequestPathVariable() async {
//        let result = await testUseCase.testRequestPathVariable()
//        
//        DispatchQueue.main.async {
//            self.pathVariableName = result?.name ?? "값 없음"
//        }
//    }
//}
