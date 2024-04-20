//
//  APIManager.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init () {}
    
    func requestData(endPoint: EndPoint) async -> DataResponse<Data, AFError> {
        
        let request = makeDataRequest(endPoint: endPoint)
        return await request.serializingData().response
    }
    
    // MARK: 기존 BaseResponse의 Result를 반환하는 메소드
    func performRequest<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
        
        var result: Data = .init()
        
        do {
            let request = await self.requestData(endPoint: endPoint)
            
            result = try request.result.get()
            
        } catch {
            print("네트워크 에러")
            return nil
        }
        
        do {
            
            let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
                        
            if decodedData.code == Constants.successResponseCode {
                print(decodedData.code)
                print(decodedData.message)
                print(decodedData.result)

                return decodedData.result
            } else {
                
                print(decodedData.code)
                print(decodedData.message)
                return nil
            }
          
        } catch {
            print("파싱 에러")
            return nil
        }
    }
    
    // MARK: BaseResponse 자체를 반환하는 메소드
    
    // 백엔드쪽과 회의 결과 모든 요청의 BaseResponse에 result를 함께 보내주는 것이 확정
    
//    func performRequest<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
//        
//        var result: Data = .init()
//        
//        do {
//            
//            let request = await requestData(endPoint: endPoint)
//            result = try request.result.get()
//            
//        } catch {
//            print("네트워크 에러")
//            return nil
//        }
//        
//        do {
//            
//            let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
//            
//            if decodedData.code == Constants.successResponseCode {
//                
//                print(decodedData.code)
//                print(decodedData.message)
//                print(decodedData.result)
//                
//                return decodedData.result
//                // 추후 추가적인 에러 처리
//                
//            } else {
//                
//                print(decodedData.code)
//                print(decodedData.message)
//                // 추후 추가적인 에러 처리
//                
//                return nil
//            }
//        
//        } catch {
//            print("파싱 에러")
//            return nil
//        }
//    }
}

extension APIManager {
    
    /// Endpoint의 task에 따라 요청 데이터 생성
    
    private func makeDataRequest(endPoint: EndPoint) -> DataRequest {
        
        switch endPoint.task {
            
        // 요청 데이터 없는 단순한 요청
        case .requestPlain:
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                headers: endPoint.headers,
                interceptor: AuthManager()
            )
            
        // RequestBody에 JSON 데이터로 요청
        case let .requsetJson(parameters):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: endPoint.headers,
                interceptor: AuthManager()
            )
            
        // RequestBody에 JSON 데이터로 요청(토큰X)
        case let .requestJsonWithoutToken(parameters):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: endPoint.headers
            )
            
        // 쿼리 파라미터 요청
        case let .requestQueryParams(parameters, encoding):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoding: encoding,
                headers: endPoint.headers,
                interceptor: AuthManager()
            )
            
        // 쿼리 파라미터 요청(토큰X)
        case let .requestQueryParamsWithoutToken(parameters, encoding):
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                parameters: parameters,
                encoding: encoding,
                headers: endPoint.headers
            )
            
        // PathVariable 요청
        case .requestPathVariable:
            return AF.request(
                "\(endPoint.baseURL)\(endPoint.path)",
                method: endPoint.method,
                headers: endPoint.headers,
                interceptor: AuthManager()
            )
            
        case let .uploadImages(images):
            return AF.upload(multipartFormData: { multipartFormData in
                for image in images {
                    if let image = image {
                        multipartFormData.append(image, withName: "img", fileName: "\(image).png", mimeType: "image/png")
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers)  // 나중에 AuthManager를 인터셉터로 해줘야 함
            
        // form 데이터 요청
        case let .uploadImagesWithData(images, body):
            return AF.upload(multipartFormData: { multipartFormData in
                for image in images {
                    if let image = image {
                        multipartFormData.append(image, withName: "img", fileName: "\(image).jpeg", mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in body {
                    if let data = String(describing: value).data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers) // 나중에 AuthManager를 인터셉터로 해줘야 함
        }
    }
}
