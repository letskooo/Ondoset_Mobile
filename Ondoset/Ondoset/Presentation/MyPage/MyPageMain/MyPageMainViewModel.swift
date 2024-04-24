//
//  MyPageMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class MyPageMainViewModel: ObservableObject {
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
//    @Published var memberProfile: MemberProfile = .init(memberId: <#T##String#>, memberName: <#T##String#>, profileImage: <#T##String#>, ootdList: <#T##[OOTD]#>, likeCount: <#T##Int#>, followingCount: <#T##Int#>)
    
    // 내 프로필 조회
    func readMyProfile() {
        
    }
    
    
    // 프로필 이미지 변경
    func changeProfileImage() {
        
    }
    
    // 닉네임 수정
    func changeNickname() {
        
    }
    
    func logout() {
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(false, forKey: "isLogin")
        }
    }
}
