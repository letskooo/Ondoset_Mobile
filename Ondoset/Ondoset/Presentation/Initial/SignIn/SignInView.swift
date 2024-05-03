//
//  SignInView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI
import Combine

struct SignInView: View {
    
    @State var idInputText: String = ""
    @State var pwInputText: String = ""
    @State var btnStatus: Bool = false

    @State private var path: NavigationPath = .init()
    
    @StateObject var signInVM: SignInViewModel = .init()

    var body: some View {
        
        NavigationStack(path: $path) {
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    Image("mainAppIcon")
                    
                    Text("ondoset")
                        .font(Font.pretendard(.bold, size: 24))
                        .foregroundStyle(.main)
                }
                .padding(.top, 35)
                
                Spacer()
                
                VStack() {
                    Image("loginIcon")
                    
                    TextFieldComponent(width: screenWidth - 50, placeholder: "아이디", inputText: $idInputText)
                        .onChange(of: idInputText) { _ in
                            signInBtnStatus()
                        }
                        
                    SecureFieldComponent(width: screenWidth - 50, placeholder: "비밀번호", inputText: $pwInputText)
                        .padding(.top, 20)
                        .onChange(of: pwInputText) { _ in
                            signInBtnStatus()
                        }
                    
                    HStack {
                        
                        Text(signInVM.signUpPhrase)
                            .font(Font.pretendard(.semibold, size: 10))
                            .foregroundStyle(signInVM.isSignInAvailable ?? true ? .clear : .red)
                        
                        Spacer()
                    }
                    .frame(width: screenWidth - 50)
                    .padding(.top, 5)
           
                    ButtonComponent(isBtnAvailable: $btnStatus, width: screenWidth - 50, btnText: "로그인", radius: 15) {
                        
                        // 로그인 API 호출
                        Task {
                            await signInVM.signInMember(username: idInputText, password: pwInputText)
                        }
                    }
                    .padding(.top, 10)
                    
                    Button {
                        path.append("SignUpFirstView")
                        
                    } label: {
                        HStack {
                            Text("회원가입")
                                .font(Font.pretendard(.semibold, size: 13))
                                .foregroundStyle(.main)

                            Image("rightChevron")
                        }
                        .padding(.top, 20)
                    }
                    .navigationDestination(for: String.self) { id in
                        
                        if id == "SignUpFirstView" {
                            SignUpFirstView(path: $path)
                        }
                        
//                        if id == "SignUpView" {
//                            SignUpView(path: $path)
//                        }
                    }
                }
                .offset(y: -20)

                Spacer()
                
                Text("Team Easy")
                    .font(Font.pretendard(.medium, size: 16))
                    .foregroundStyle(.darkGray)
                    .padding(.bottom, 25)
            }
        }
    }
    
    private func signInBtnStatus() {
        if !idInputText.isEmpty && !pwInputText.isEmpty {
            btnStatus = true
        } else {
            btnStatus = false
        }
    }
}

#Preview {
    SignInView()
}
