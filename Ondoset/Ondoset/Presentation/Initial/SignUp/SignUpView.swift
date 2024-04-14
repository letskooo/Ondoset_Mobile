//
//  SignUpView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct SignUpView: View {
    
    // @State
    @State var idInputText: String = ""
    @State var pwInputText: String = ""
    @State var pwCheckInputText: String = ""
    
    @State var duplicateIdCheckBtnStatus: BtnStatus = .off
    @State var nextBtnStatus: BtnStatus = .off
    
    @State var idPhrase: String = "8자리 이상 아이디를 입력해주세요!"
    @State var pwPhrase: String = "8자리 이상, 영문 및 숫자를 포함한 비밀번호를 입력해주세요!"
    @State var pwCheckPhrase: String = "비밀번호가 일치합니다."
    
    @State var isIdPhraseHidden: Bool = false
    @State var isPwPhraseHidden: Bool = false
    @State var isPwCheckPhraseHidden: Bool = true
    
    // @Binding
    @Binding var path: [InitialViews]
    
    // @StateObject
    @StateObject var signUpVM: SignUpViewModel = .init()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    TextFieldComponent(width: 250, placeholder: "아이디", inputText: $idInputText)
                        .onChange(of: idInputText) { id in
                            
                            signUpVM.idConditionCheck(id: id, isIdPhraseHidden: $isIdPhraseHidden, duplicateIdCheckBtnStatus: $duplicateIdCheckBtnStatus)
                        }
                    
                    ButtonComponent(btnStatus: $duplicateIdCheckBtnStatus, width: 80, btnText: "중복 확인", radius: 8) {
                        
                        // 중복 확인 API 호출
                        // 만약 중복된 결과가 나올 경우
                        // idCheckPhrase = "중복된 아이디입니다. 새로운 아이디를 입력해주세요." 빨간색 텍스트
                        // 중복되지 않은 결과가 나올 경우
                        // "사용 가능한 아이디입니다." 하고 파란색 텍스트
                        
                        // 이곳에 updateBtnStatus() 로직 들어가야 함
                        
                    }
                    .padding(.leading, 10)
                }
    
                Text(idPhrase)
                    .font(Font.pretendard(.semibold, size: 10))
                    .padding(.top, 12)
                    .padding(.leading, 15)
                    .hidden(isIdPhraseHidden)
            }
            .padding(.top, 90)
            
            VStack(alignment: .leading, spacing: 0) {
                
                TextFieldComponent(width: 340, placeholder: "비밀번호", inputText: $pwInputText)
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
                TextFieldComponent(width: 340, placeholder: "비밀번호 확인", inputText: $pwCheckInputText)
                    .padding(.top, 20)
                    .onChange(of: pwCheckInputText) { _ in
                        
                        if pwInputText == pwCheckInputText {
                            isPwCheckPhraseHidden = false
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
            
            ButtonComponent(btnStatus: $nextBtnStatus, width: 340, btnText: "다음으로", radius: 15) {
                
                if nextBtnStatus == .on {
                    path.append(InitialViews.RegisterNickNameView)
                }
            }
            .padding(.top, 70)
            
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
    
    
}

#Preview {
    SignUpView(path: .constant([]))
}
