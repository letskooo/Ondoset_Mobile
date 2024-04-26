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
    
    @Published var memberProfile: MemberProfile?
    
    var lastPage: Int = -1

    init() {
        
        Task {
            
            await readMyProfile()
        }
    }
    
    // 내 프로필 조회
    func readMyProfile() async {
        
        if let profile = await ootdUseCase.readMyProfile() {
            
            print("======")
            print(profile.profileImage)
            print("======")
            
            DispatchQueue.main.async {
                self.memberProfile = profile
            }
        }
    }
    
    // 내 프로필 페이징
    func pagingMyProfileOOTD() async {
        
        if lastPage != -2 {
            if let result = await ootdUseCase.pagingMyProfileOOTD(lastPage: lastPage) {
                DispatchQueue.main.async {
                    self.memberProfile?.ootdList.append(contentsOf: result.ootdList)
                    
                    self.lastPage = result.lastPage
                }
            }
        }
    }
    
    // 프로필 이미지 변경
    func changeProfileImage() {
        
    }
    
    // 닉네임 수정
    func changeNickname() {
        
    }
    
    // 로그아웃
    func logout() {
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(false, forKey: "isLogin")
        }
    }
    
    // 회원 탈퇴
    func withdrawMember() async {
        
        _ = await memberUseCase.withdrawMember()
    }
}
