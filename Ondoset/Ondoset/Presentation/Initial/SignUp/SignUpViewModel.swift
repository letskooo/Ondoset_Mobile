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
    
    @Published var idInputText: String = ""
    @Published var pwInputText: String = ""
    @Published var nicknameInputText: String = ""
    
    @Published var nextBtnStatus: Bool = false
    @Published var idAvailable: IdStatus = .before
    @Published var nicknameAvailable: Bool = false
    
    @Published var isSignUpDone: Bool = false
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    var cancleables = Set<AnyCancellable>()
    
    // 회원가입 아이디 조건 체크
    func idConditionCheck(id: String, isIdPhraseHidden: Binding<Bool>, duplicateIdCheckBtnStatus: Binding<Bool>) {
        
        if id.count >= 8 {
            isIdPhraseHidden.wrappedValue = true
            duplicateIdCheckBtnStatus.wrappedValue = true
        } else {
            isIdPhraseHidden.wrappedValue = false
            duplicateIdCheckBtnStatus.wrappedValue = false
        }
    }
    
    // 회원가입 비밀번호 조건 체크
    func pwConditionCheck(pw: String, isPwPhraseHidden: Binding<Bool>) {
        let pwCondition = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let pwValid = NSPredicate(format: "SELF MATCHES %@", pwCondition)
        
        if pwValid.evaluate(with: pw) {
            
            isPwPhraseHidden.wrappedValue = true
        } else {
            isPwPhraseHidden.wrappedValue = false
        }
    }
    
    // MARK: API
    
    // 아이디 중복 체크
    func checkDuplicateId() async {
        
        await memberUseCase.checkDuplicateId(memberId: idInputText)
            .receive(on: DispatchQueue.main)
            .sink { result in
                
                if result.usable {
                    self.idAvailable = .available
                } else {
                    self.idAvailable = .unavailable
                }
            }
            .store(in: &cancleables)
    }
    
    // 닉네임 중복 체크
    func checkDuplicateNickname() async {
        
        await memberUseCase.checkDuplicateNickname(nickname: nicknameInputText)
            .receive(on: DispatchQueue.main)
            .sink { result in
                
                self.nicknameAvailable = result.usable ? true : false
            }
            .store(in: &cancleables)
    }
    
    // 회원가입
    func signUpMember() async {
        
        await memberUseCase.signUpMember(memberId: idInputText, password: pwInputText, nickname: nicknameInputText)
            .receive(on: DispatchQueue.main)
            .sink { result in
                
                if result == "회원가입 성공" {
                    self.isSignUpDone = true
                }
            }
            .store(in: &cancleables)
    }
}
