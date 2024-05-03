//
//  MemberRepository.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

final class MemberRepository {
    
    static let shared = MemberRepository()
    
    
    // 아이디 중복 체크
    func checkDuplicateId(username: String) async -> DuplicateCheckResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.checkIdDuplicate(username: username))
    }
    
    // 닉네임 중복 체크
    func checkDuplicatedNickname(nickname: String) async -> DuplicateCheckResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.checkNicknameDuplicate(nickname: nickname))
    }
    
    // 회원가입
    func signUpMember(signUpDTO: SignUpRequestDTO) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.signUpMember(signUpDTO: signUpDTO))
    }
    
    // 로그인
    func signInMember(signInDTO: SignInRequestDTO) async -> SignInResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.signInMember(signInDTO: signInDTO))
    }
    
    // 온보딩 결과 저장
    func saveOnboarding(onboardingDTO: OnboardingRequestDTO) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.saveOnboarding(onboardingDTO: onboardingDTO))
    }
    
    // 회원탈퇴
    func withdrawMember() async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.withdrawMember)
    }
    
    // 닉네임 수정
    func updateNickname(nickname: String) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.updateNickname(nickname: nickname))
    }
    
    // 프로필 이미지 수정
    func updateProfileImage(profileImage: Data) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: MemberEndPoint.updateProfileImage(profileImage: profileImage))
    }
}
