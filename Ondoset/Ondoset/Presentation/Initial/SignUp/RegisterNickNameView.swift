//
//  RegisterNickNameView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/11/24.
//

import SwiftUI

struct RegisterNickNameView: View {
    
    // 회원가입 버튼 활성화 여부
    @State var signUpBtnStatus: Bool = false
    
    // 닉네임 중복 확인 버튼 활성화 여부
    @State var duplicateNicknameCheckBtnStatus: Bool = false
    
    @State var isNicknameWarningHidden: Bool = true
    
    // @Binding
    @Binding var path: [String]
    
    @ObservedObject var signUpVM: SignUpViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("사용하실 닉네임을 알려주세요")
                .font(Font.pretendard(.semibold, size: 17))
            
            HStack {
                TextFieldComponent(width: 250, placeholder: "아이디", inputText: $signUpVM.nicknameInputText)
                    .onChange(of: signUpVM.nicknameInputText) { nickname in
                        
                        if nickname.count > 0 {
                            duplicateNicknameCheckBtnStatus = true
                        } else {
                            duplicateNicknameCheckBtnStatus = false
                            signUpBtnStatus = false
                        }
                        
                    }
                
                ButtonComponent(isBtnAvailable: $duplicateNicknameCheckBtnStatus, width: 80, btnText: "중복 확인", radius: 8) {
                    
                    Task {
                        await signUpVM.checkDuplicateNickname()
                    }
                    
                }
            }
            .padding(.top, 16)
            .onChange(of: signUpVM.nicknameAvailable) { _ in
                
                if signUpVM.nicknameAvailable {
                    self.signUpBtnStatus = true
                    isNicknameWarningHidden = false
                } else {
                    self.signUpBtnStatus = false
                    isNicknameWarningHidden = false
                }
            }
            
            Text(signUpVM.nicknameAvailable ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다. 다른 닉네임을 입력해주세요.")
                .font(Font.pretendard(.semibold, size: 10))
                .padding(.top, 12)
                .padding(.leading, 15)
                .foregroundStyle(signUpVM.nicknameAvailable ? .blue : .red)
                .hidden(isNicknameWarningHidden)
            
            ButtonComponent(isBtnAvailable: $signUpBtnStatus, width: 340, btnText: "회원가입", radius: 15) {
                
                // 회원가입 API
                
                Task {
                    await signUpVM.signUpMember()
                    
                    if signUpVM.isSignUpDone {
                        path.removeAll()
                    }
                }
            }
            .padding(.top, 80)
            
            Spacer()
        }
        .padding(.top, 70)
        .navigationTitle("회원 가입")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                    dismiss()
                } label: {
                    Image("leftChevron")
                }
            }
        }
    }
}

#Preview {
    RegisterNickNameView(path: .constant([]), signUpVM: SignUpViewModel())
}
