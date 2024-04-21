//
//  SignUpViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/11/24.
//

import Foundation
import SwiftUI
import Combine

enum IdStatus {
    case before
    case available
    case unavailable
}

class SignUpViewModel: ObservableObject {
    
    /// SignUpFirstView
    
    /// 아이디 상태 유지
    @Published var idInputText: String = ""
    @Published var isIdAvailable: Bool = false
    @Published var idPhrase: String = "영문 8글자 이상의 아이디를 입력해주세요"
    @Published var isIdCheckBtnAvailable: Bool = false
    
    /// 비밀번호 상태 유지
    @Published var pwInputText: String = ""
    @Published var pwPhrase: String = "영문 및 숫자를 포함한 8자리 이상의 비밀번호를 입력해주세요"
    @Published var isPwAvailable: Bool = false
    
    /// 비밀번호 확인 상태 유지
    @Published var pwCheckInputText: String = ""
    @Published var pwCheckPhrase: String = "비밀번호가 일치하지 않습니다"
    @Published var isPwCheckCorrespond: Bool = false
    
    // 다음으로 가기 버튼 활성화 여부
    @Published var isNextBtnAvailable: Bool = false
    
    
    /// SignUpSecondView
    @Published var nicknameInputText: String = ""
    @Published var isNicknameAvailable: Bool = false
    @Published var nicknamePhrase: String = ""
    @Published var isNicknamePhraseHidden: Bool = true
    
    @Published var isNicknameCheckBtnAvailable: Bool = false
    @Published var isSignUpBtnAvailable: Bool = false
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    
    // 다음으로 가기 버튼 활성화
    func updateBtnStatus() {
        
        isNextBtnAvailable = (isIdAvailable && isPwAvailable && isPwCheckCorrespond ? true : false)
    }
    
    // 회원가입 버튼 활성화
    func signUpBtnStatus() {
        isSignUpBtnAvailable = (isIdAvailable && isPwAvailable && isPwCheckCorrespond && isNicknameAvailable ? true : false)
    }
    
    
    // 회원가입 아이디 조건 체크
    func idConditionCheck(id: String) {
        
        let idCondition = "^(?=.*[A-Za-z])[A-Za-z\\d]{8,}$"
        
        let idValid = NSPredicate(format: "SELF MATCHES %@", idCondition)
        
        if idValid.evaluate(with: id) {
            isIdCheckBtnAvailable = true
            idPhrase = "올바른 형식입니다. 중복 확인을 해주세요."
        } else {
            isIdCheckBtnAvailable = false
            idPhrase = "영문 8글자 이상의 아이디를 입력해주세요"
        }
    }
    
    // 회원가입 비밀번호 조건 체크
    func pwConditionCheck(pw: String) {
        
        let pwCondition = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let pwValid = NSPredicate(format: "SELF MATCHES %@", pwCondition)
        
        if pwValid.evaluate(with: pw) {
            
            isPwAvailable = true
        } else {
            isPwAvailable = false
        }
        
        pwPhrase = (isPwAvailable ? "올바른 형식입니다." : "영문 및 숫자를 포함한 8자리 이상의 비밀번호를 입력해주세요.")
        
        updateBtnStatus()
        signUpBtnStatus()
    }
    
    // MARK: API
    
    // 아이디 중복 체크
    func checkDuplicateId() async {
        
        if let isIdAvailable = await memberUseCase.checkDuplicateId(memberId: idInputText) {
            
            if isIdAvailable {
                self.isIdAvailable = true
                self.updateBtnStatus()
            } else {
                self.isIdAvailable = false
                self.updateBtnStatus()
            }
        }
    }
    
    // 닉네임 중복 체크
    func checkDuplicateNickname() async {
        
        if let isNicknameAvailable = await memberUseCase.checkDuplicateNickname(nickname: nicknameInputText) {
            
            isNicknamePhraseHidden = false
            
            if isNicknameAvailable {
                self.isNicknameAvailable = true
                self.signUpBtnStatus()
            } else {
                self.isNicknameAvailable = false
                self.signUpBtnStatus()
            }
        }
    }
    
    // 회원가입
    func signUpMember() async {
        
        _ = await memberUseCase.signUpMember(signUpDTO: SignUpRequestDTO(memberId: idInputText, password: pwInputText, nickname: nicknameInputText))
    }
}
