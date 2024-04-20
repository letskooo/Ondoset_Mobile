//
//  SignUpView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct SignUpView: View {
    
    // 아이디 입력값
    @State var idInputText: String = ""
    
    // 비밀번호 입력값
    @State var pwInputText: String = ""
    
    // 비밀번호 확인 입력값
    @State var pwCheckInputText: String = ""
    
    // 아이디 중복 확인 버튼 활성화 여부
    @State var duplicateIdCheckBtnStatus: Bool = false
    
    // 아이디 안내문
    @State var idPhrase: String = "8자리 이상 아이디를 입력해주세요!"
    
    // 비밀번호 안내문
    @State var pwPhrase: String = "8자리 이상, 영문 및 숫자를 포함한 비밀번호를 입력해주세요!"
    
    // 비밀번호 확인 안내문
    @State var pwCheckPhrase: String = "비밀번호가 일치합니다."
    
    // 아이디 안내문 숨기기 여부
    @State var isIdPhraseHidden: Bool = false
    
    // 비밀번호 안내문 숨기기 여부
    @State var isPwPhraseHidden: Bool = false
    
    // 비밀번호 확인 안내문 숨기기 여부
    @State var isPwCheckPhraseHidden: Bool = true
    
    @StateObject var signUpVM: SignUpViewModel = .init()
    
    // @Binding
    @Binding var path: [String]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    TextFieldComponent(width: 250, placeholder: "아이디", inputText: $idInputText)
                        .onChange(of: idInputText) { id in
                            
                            signUpVM.idConditionCheck(id: id, isIdPhraseHidden: $isIdPhraseHidden, duplicateIdCheckBtnStatus: $duplicateIdCheckBtnStatus)
                        }
                    
                    ButtonComponent(isBtnAvailable: $duplicateIdCheckBtnStatus, width: 80, btnText: "중복 확인", radius: 8) {
                        
                        Task {
                            await signUpVM.checkDuplicateId()
                        }
                    }
                    .padding(.leading, 10)
                }
    
                Text(idPhrase)
                    .font(Font.pretendard(.semibold, size: 10))
                    .padding(.top, 12)
                    .padding(.leading, 15)
                    .foregroundStyle(signUpVM.idAvailable == .available ? .blue : .red)
                    .hidden(isIdPhraseHidden)
            }
            .padding(.top, 90)
            .onChange(of: signUpVM.idAvailable) { _ in
                
                if signUpVM.idAvailable == .available {
                    idPhrase = "사용 가능한 아이디입니다."
                    isIdPhraseHidden = false
                    updateBtnStatus()
                } else if signUpVM.idAvailable == .unavailable {
                    idPhrase = "중복된 아이디입니다. 다른 아이디를 입력해주세요."
                    isIdPhraseHidden = false
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                SecureFieldComponent(width: 340, placeholder: "비밀번호", inputText: $pwInputText)
                    .onChange(of: pwInputText) { pw in
                        
                        signUpVM.pwConditionCheck(pw: pw, isPwPhraseHidden: $isPwPhraseHidden)
                    }
                    
                Text(pwPhrase)
                    .font(Font.pretendard(.semibold, size: 10))
                    .padding(.top, 12)
                    .padding(.leading, 15)
                    .hidden(isPwPhraseHidden)
            }
            .padding(.top, 50)
            
            
            VStack(alignment: .leading, spacing: 0) {
                SecureFieldComponent(width: 340, placeholder: "비밀번호 확인", inputText: $pwCheckInputText)
                    .padding(.top, 20)
                    .onChange(of: pwCheckInputText) { _ in
                        
                        if pwInputText == pwCheckInputText {
                            isPwCheckPhraseHidden = false
                            updateBtnStatus()
                        } else {
                            isPwCheckPhraseHidden = true
                        }
                    }
                
                Text(pwCheckPhrase)
                    .font(Font.pretendard(.semibold, size: 10))
                    .padding(.top, 12)
                    .padding(.leading, 15)
                    .hidden(isPwCheckPhraseHidden)
            }
            
            NavigationLink(destination: RegisterNickNameView(path: $path, signUpVM: signUpVM)) {
                
                Rectangle()
                    .foregroundStyle(signUpVM.nextBtnStatus ? .main : .lightGray)
                    .frame(width: 340, height: 50)
                    .cornerRadius(15)
                    .overlay(
                        Text("다음으로")
                            .font(Font.pretendard(.bold, size: 17))
                            .foregroundStyle(signUpVM.nextBtnStatus ? .white : .darkGray)
                    )
                
            }
            
            Spacer()
            
        }
        .navigationTitle("회원 가입")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                    path.removeLast()
                } label: {
                    Image("leftChevron")
                }
            }
        }
    }
    
    private func updateBtnStatus() {
        
        if signUpVM.idAvailable == .available && isPwCheckPhraseHidden == false {
            signUpVM.nextBtnStatus = true
        } else {
            signUpVM.nextBtnStatus = false
        }
    }
}

#Preview {
    SignUpView(signUpVM: SignUpViewModel(), path: .constant([]))
}
