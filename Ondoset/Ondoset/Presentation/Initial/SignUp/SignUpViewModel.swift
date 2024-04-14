//
//  SignUpViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/11/24.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    // 회원가입 아이디 조건 체크
    func idConditionCheck(id: String, isIdPhraseHidden: Binding<Bool>, duplicateIdCheckBtnStatus: Binding<BtnStatus>) {
        
        if id.count >= 8 {
            isIdPhraseHidden.wrappedValue = true
            duplicateIdCheckBtnStatus.wrappedValue = .on
        } else {
            isIdPhraseHidden.wrappedValue = false
            duplicateIdCheckBtnStatus.wrappedValue = .off
        }
    }
    
    // 회원가입 중복 체크
    // func
    
    
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
    
    // 닉네임 중복 체크
    // func
    
}
