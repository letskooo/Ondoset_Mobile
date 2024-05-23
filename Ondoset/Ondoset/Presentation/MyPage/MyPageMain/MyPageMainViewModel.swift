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
    
    @Published var myOOTDList: [OOTD] = []
    
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
            
            print("================")
            print(profile.profileImage)
            print("======")
            
            DispatchQueue.main.async {
                self.memberProfile = profile
                self.myOOTDList = profile.ootdList
                self.lastPage = profile.lastPage
            }
        }
    }
    
    // 내 프로필 페이징
    func pagingMyProfileOOTD() async {
        
        if lastPage != -2 {
            if let result = await ootdUseCase.pagingMyProfileOOTD(lastPage: lastPage) {
                DispatchQueue.main.async {
                    self.myOOTDList.append(contentsOf: result.ootdList)
                    
                    self.lastPage = result.lastPage
                }
            }
        }
    }
    
    // 프로필 이미지 변경
    func changeProfileImage(profileImage: Data) async -> Bool {
        
        if let result = await memberUseCase.updateProfileImage(profileImage: profileImage) {
            return true
        } else {
            return false
        }
        
    }
    
    // 닉네임 중복 확인
    func checkNicknameDuplicate(nickname: String) async -> Bool {
        
        if let result = await memberUseCase.checkDuplicateNickname(nickname: nickname) {
            
            return true
        } else {
            return false
        }
    }
    
    // 닉네임 수정
    func changeNickname(newNickname: String) async -> Bool {
        
        if let result = await memberUseCase.updateNickname(updateNicknameDTO: UpdateNicknameRequestDTO(nickname: newNickname)) {
            
            return true
            
        } else {
            return false
        }
    }
    
    // 로그아웃
    func logout() {
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(false, forKey: "isLogin")
        }
    }
    
    // 회원 탈퇴
    func withdrawMember() async {
        
        if let result = await memberUseCase.withdrawMember() {
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
            }
        }
    }
}
