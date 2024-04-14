//
//  RegisterNickNameView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/11/24.
//

import SwiftUI

struct RegisterNickNameView: View {
    
    @State var btnStatus: BtnStatus = .on
    @State var nicknameInputText: String = ""
    @State var duplicateNicknameCheckBtnStatus: BtnStatus = .on
    @State var isNicknameWarningHidden: Bool = false
    
    // @Binding
    @Binding var path: [SignUpViews]
    
    // @Object
    @EnvironmentObject var signUpVM: SignUpViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("사용하실 닉네임을 알려주세요")
                .font(Font.pretendard(.semibold, size: 17))
            
            HStack {
                TextFieldComponent(width: 250, placeholder: "아이디", inputText: $nicknameInputText)
                
                ButtonComponent(btnStatus: $duplicateNicknameCheckBtnStatus, width: 80, btnText: "중복 확인", radius: 8) {
                    
                    // 중복 확인 API 호출
                    
                }
            }
            .padding(.top, 16)
            
            Text("사용 가능한 닉네임입니다.")
                .font(Font.pretendard(.semibold, size: 10))
                .padding(.top, 12)
                .padding(.leading, 15)
                .hidden(isNicknameWarningHidden)
            
            ButtonComponent(btnStatus: $btnStatus, width: 340, btnText: "회원가입", radius: 15) {
                path.removeAll()
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
                    path.removeLast()
                } label: {
                    Image("leftChevron")
                }
                
            }
        }
        
        
        
    }
}

#Preview {
    RegisterNickNameView(path: .constant([]))
}
