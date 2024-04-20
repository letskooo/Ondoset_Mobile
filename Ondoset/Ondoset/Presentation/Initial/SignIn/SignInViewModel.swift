//
//  SignInViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/18/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    
    // 로그인
    func signInMember(memberId: String, password: String) async {
        
        await memberUseCase.signInMember(signInDTO: SignInRequestDTO(memberId: memberId, password: password))
        
    }
}
