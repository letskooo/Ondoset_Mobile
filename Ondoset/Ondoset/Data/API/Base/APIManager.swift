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
            
            print(String(data: result, encoding: .utf8))
            
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
            print("디코딩 에러")
            return nil
        }
    }
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
        case let .requestJson(parameters):
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
            
        // form 데이터로 이미지 전송
        case let .uploadImage(image):
            return AF.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(image, withName: "img", fileName: "\(image).jpeg", mimeType: "image/jpeg")
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers)
            
        // form 데이터 요청
        case let .uploadImagesWithData(image, body):
            return AF.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(image, withName: "img", fileName: "\(image).jpeg", mimeType: "image/jpeg")
                
                for (key, value) in body {
                    if let data = String(describing: value).data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers) // 나중에 AuthManager를 인터셉터로 해줘야 함
        }
    }
}
