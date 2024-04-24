//
//  MemberUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation
import Combine

class MemberUseCase {
    
    static let shared = MemberUseCase()
    
    let memberRepository: MemberRepository = MemberRepository.shared
    
    // 아이디 중복 체크 요청
    func checkDuplicateId(memberId: String) async -> Bool? {
        
        guard let result = await memberRepository.checkDuplicateId(memberId: memberId) else {
            return nil
        }
        
        if result.usable {  // 아이디가 중복되지 않았을 때
            
            print("사용 가능 여부: \(result.usable)")
            
            return true
            
        } else {    // 아이디가 중복됐을 때
            
            print("사용 가능 여부: \(result.usable)")
            
            return false
        }
    }
    
    // 닉네임 중복 체크 요청
    func checkDuplicateNickname(nickname: String) async -> Bool? {
        
        guard let result = await memberRepository.checkDuplicatedNickname(nickname: nickname) else {
            return nil
        }
        
        if result.usable {  // 닉네임이 중복되지 않았을 때
            
            return true
            
        } else {    // 닉네임이 중복됐을 때
            
            return false
        }
    }
    
    // 회원가입
    func signUpMember(signUpDTO: SignUpRequestDTO) async {
        
        _ = await memberRepository.signUpMember(signUpDTO: signUpDTO)
    }
    
    // 로그인
    func signInMember(signInDTO: SignInRequestDTO) async -> Bool? {
        
        guard let result = await memberRepository.signInMember(signInDTO: signInDTO) else {
            
            return false
        }
        
        KeyChainManager.addItem(key: "accessToken", value: result.accessToken)
        KeyChainManager.addItem(key: "refreshToken", value: result.refreshToken)
        
        print("accessToken: \(result.accessToken)")
        print("refreshToken: \(result.refreshToken)")
        print("isFirst: \(result.isFirst)")
        
        DispatchQueue.main.async {
            
            // 로그인 완료
            UserDefaults.standard.set(true, forKey: "isLogin")
            
            // 신규 사용자 여부
            UserDefaults.standard.set(result.isFirst, forKey: "isFirst")
        }
        
        return true
    }
    
    // 온보딩 결과 저장
    func saveOnboarding(onboardingDTO: OnboardingRequestDTO) async {
        
        _ = await memberRepository.saveOnboarding(onboardingDTO: onboardingDTO)
        
        DispatchQueue.main.async {
            
            // 온보딩 완료로 신규 사용자 여부 false
            UserDefaults.standard.set(false, forKey: "isFirst")
        }
    }
    
    // 회원 탈퇴
    func withdrawMember() async {
        
        _ = await memberRepository.withdrawMember()
        
    }
    
    // 닉네임 변경
    func updateNickname(nickname: String) async {
        
        _ = await memberRepository.updateNickname(nickname: nickname)
    }
    
    // 프로필 이미지 변경
    func updateProfileImage(profileImage: Data) async {
        
        _ = await memberRepository.updateProfileImage(profileImage: profileImage)
    }
}
