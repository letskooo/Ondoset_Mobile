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
    
    static let shared = AuthManager()
    
    private var retryLimit = 2
    
    /// URLRequest를 보내는 과정을 가로채, Request의 내용을 변경함
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // baseURL 확인
        guard urlRequest.url?.absoluteString.hasPrefix(Constants.serverURL) == true else { return }
        
        // Access Token 조회
        guard let accessToken = KeyChainManager.readItem(key: "accessToken") else {
            
            // accessToken이 없을 경우 강제 로그아웃
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
            }

            return
        }
        
        // URLRequest 헤더 추가. return
        var urlRequest = urlRequest

        urlRequest.headers.add(.authorization(bearerToken: accessToken))

        completion(.success(urlRequest))
        
    }
    
    /// Request 요청이 실패했을 때, 재시도 여부 결정
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        
        print("=====retry 호출됨=========")
        
        // 횟수를 정해서 재시도를 함
        // 근데 그거를 넘어서도 안 되면 Alert를 띄둔다
        // 인터넷 상태 꽝임
        
        if request.retryCount < self.retryLimit {
            
            print("기존 요청 재시도")
            
            completion(.retry)
            
        } else {
            
            completion(.doNotRetry)
            
            print("인터넷 연결이 좋지 않음. 잠시 후 다시 시도해주세요.")
        }
    }
}
