//
//  AuthManager.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//


/// 요청에 인증 토큰을 더하는 AuthManager 파일입니다.

import Foundation
import Alamofire

class AuthManager: RequestInterceptor {
    
    private var retryLimit = 2
    
    /// URLRequest를 보내는 과정을 가로채, Request의 내용을 변경함
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // baseURL 확인
        
        /// 학과 서버
        //guard urlRequest.url?.absoluteString.hasPrefix(serverURL) == true else { return }
        
        /// EC2
        guard urlRequest.url?.absoluteString.hasPrefix(ec2URL) == true else { return }
        
        // Access Token 조회
        guard let accessToken = KeyChainManager.readItem(key: "accessToken") else {
            
            // accessToken이 없을 경우 강제 로그아웃
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
            }
        
//            completion(.failure(APIError.customError("키체인 토큰 조회 실패. 로그인이 필요합니다.")))
            return
        }
        
        // URLRequest 헤더 추가. return
        var urlRequest = urlRequest
//        urlRequest.headers.add(.authorization(accessToken))
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        
        completion(.success(urlRequest))
        
    }
    
    /// Request 요청이 실패했을 때, 재시도 여부 결정
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        
        // HTTP 응답 코드 확인, 재시도 여부 결정
        // 400 상태 코드가 아니라면 Error 메시지와 함께 재시도하지 않음.
        // 즉 400이면 재시도
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 400 else {
            
            completion(.doNotRetryWithError(error))
            return
        }
        
        // 해당 경로로 accessToken 재발급 요청
        // 현재 임시 URL. 추후 수정 필요
        
        /// 학과 서버
        //guard let url = URL(string: serverURL+"/member/jwt") else { return }
        
        /// EC2
        guard let url = URL(string: ec2URL+"/member/jwt") else { return }
        
        guard let accessToken = KeyChainManager.readItem(key: "accessToken"),
              let refreshToken = KeyChainManager.readItem(key: "refreshToken") else {
            
            // 토큰 없는 경우 로그아웃 처리
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
            }
//            
//            // 이것처럼 처리도 가능
//            completion(.doNotRetryWithError(APIError.customError("키체인 토큰 조회 실패. 로그인이 필요합니다.")))
            return
        }
        
        // refresh만 받으면 그거에 맞게 수정
        let parameters: Parameters = [
            
            "accessToken" : accessToken,
            "refreshToken" : refreshToken
        ]
        
        AF.request(url, method: .post, parameters: parameters,
                   encoding: JSONEncoding.default).validate().responseDecodable(of: TokenReissuanceResponseDTO.self) { response in
            
            switch response.result {
                
                // 재발급 성공
                case .success(let result):
                    
                    // 재발급된 토큰을 키체인에 저장
                    KeyChainManager.addItem(key: "accessToken", value: result.accessToken)
                    //KeyChainManager.addItem(key: "refreshToken", value: result.refreshToken)
                    
                    // 기존에 보내고자 했던 요청 재시도
                    // 재시도 횟수 내일 때만 재시도
                    request.retryCount < self.retryLimit ?
                    completion(.retry) : completion(.doNotRetry)
    //                completion(.retry) : completion(.doNotRetryWithError(APIError.customError("재시도 횟수 초과"))) //
                    
                // 재발급 실패(refreshToken 만료)
                case .failure(let error):
                    // 토큰 갱신 실패 시 에러 처리
                    print(error)
                    
                    // 로그인 화면으로 이동
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isLogin")
                     
                    }
                    
                    // 이것도 가능
                    completion(.doNotRetryWithError(error))
                    print("토큰 갱신 에러. 로그인 필요")
                }
                
            }
//            
        }
}
