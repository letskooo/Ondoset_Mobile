//
//  SignInViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/18/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var isSignInAvailable: Bool? = nil
    @Published var signUpPhrase: String = "잘못된 정보입니다. 다시 입력해주세요"
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    
    // 로그인
    func signInMember(username: String, password: String) async {
        
        if let result = await memberUseCase.signInMember(signInDTO: SignInRequestDTO(username: username, password: password)) {
            
            if !result {
                
                DispatchQueue.main.async {
                    self.isSignInAvailable = false
                }
            }
        }
    }
}
