//
//  SettingView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import SwiftUI
import Kingfisher

struct SettingView: View {
    
    @State var profileImage: UIImage = UIImage()
    @State var openPhoto: Bool = false
    
    @State var isNotificationAvailable: Bool = false
    
    @State var isProfileImageChanged: Bool = false
    
    @State var logOutShowAlert: Bool = false
    @State var withdrawShowAlert: Bool = false
    
    // 닉네임 변경 sheet 활성화 여부
    @State var isUpdateNicknameSheetPresented: Bool = false
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
    
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    
                    if isProfileImageChanged {
                        
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 96, height: 96)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay {
                                Circle().stroke(.main, lineWidth: 0.5)
                            }
                            .overlay {
                                Image("addBtnWhite")
                                    .offset(x: 40, y: 40)
                            }
                            .onTapGesture {
                                openPhoto = true
                            }
                        
                    } else {
                        
                        if let imageURL = myPageVM.memberProfile?.profileImage, let url = URL(string: imageURL) {
                            
                            KFImage(url)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 96, height: 96)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .overlay {
                                    Circle().stroke(.main, lineWidth: 0.5)
                                }
                                .overlay {
                                    Image("addBtnWhite")
                                        .offset(x: 40, y: 40)
                                }
                                .onTapGesture {
                                    openPhoto = true
                                }
                            
                        } else {
                            
                            Image("basicProfileIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 96, height: 96)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .overlay {
                                    Circle().stroke(.main, lineWidth: 0.5)
                                }
                                .overlay {
                                    Image("addBtnWhite")
                                        .offset(x: 40, y: 40)
                                }
                                .onTapGesture {
                                    openPhoto = true
                                }
                        }
                    }

                    Text(myPageVM.memberProfile?.username ?? "사용자 아이디")
                        .font(Font.pretendard(.medium, size: 13))
                        .padding(.top, 16)
                    
                    HStack(spacing: 0) {
                        
                        
                        
                        Text(myPageVM.memberProfile?.nickname ?? "사용자 닉네임")
                            .font(Font.pretendard(.medium, size: 15))
                            
                        
                        Image("pencil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .padding(.leading, 5)
                        
                        
                    }
                    .padding(.top, 10)
                    .onTapGesture {
                        isUpdateNicknameSheetPresented = true
                    }

                  
                }
                
                Rectangle()
                    .frame(width: screenWidth, height: 10)
                    .foregroundStyle(Color(hex: 0xF5F4F3))
                    .padding(.top, 24)
                
                SettingComponent(title: "테마 설정") {}
                SettingComponent(title: "알림 설정") {}
                SettingComponent(title: "이용 약관") {}
                SettingComponent(title: "개인정보 처리방침") {}
                SettingComponent(title: "로그아웃") {
                 
                    logOutShowAlert = true
                }
                SettingComponent(title: "회원탈퇴") {
                    withdrawShowAlert = true
                }
                
                Spacer()

            }
            
            if logOutShowAlert {
                
                AlertComponent(showAlert: $logOutShowAlert, alertTitle: "로그아웃", alertContent: "정말 로그아웃 하시겠어요?", rightBtnTitle: "확인", rightBtnAction: {
                    myPageVM.logout()
                })
            }
            
            if withdrawShowAlert {
                AlertComponent(showAlert: $withdrawShowAlert, alertTitle: "회원 탈퇴", alertContent: "정말 회원 탈퇴를 하시겠어요? \n기록된 정보는 전부 삭제됩니다", rightBtnTitle: "확인", rightBtnAction: {
                    Task {
                        await myPageVM.withdrawMember()
                    }
                })
            }
            
        }
        .navigationTitle("설정")
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
        .sheet(isPresented: $openPhoto, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $profileImage)
        })
        .sheet(isPresented: $isUpdateNicknameSheetPresented, content: {
            
            UpdateNicknameView(myPageVM: myPageVM, isUpdateNicknameSheetPresented: $isUpdateNicknameSheetPresented)
                .presentationDetents([.height(screenHeight / 3.5)])
        })
        .onChange(of: profileImage) { image in
            
            Task {
                
                if let imageData = image.jpegData(compressionQuality: 0.1) {
                    
                    let result = await myPageVM.changeProfileImage(profileImage: imageData)
                    
                    if result {
                        
                        isProfileImageChanged = true
                    }
                }
            }
        }
        .onDisappear {
            
            Task {
                await myPageVM.readMyProfile()
            }
            
        }
    }
}

// 닉네임 변경 뷰
struct UpdateNicknameView: View {
    
    @State var newNicknameInputText: String = ""
    @State var isNewNicknameAvailable: Bool = false
    @State var nicknamePhrase: String = ""
    @State var isNicknamePhraseHidden: Bool = true
    
    @State var isNicknameCheckBtnAvailable: Bool = false
    @State var isRegisterBtnAvailable: Bool = false
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    @Binding var isUpdateNicknameSheetPresented: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                Button {
                    
                    isUpdateNicknameSheetPresented.toggle()
                    
                } label: {
                    Text("닫기")
                        .padding(.leading, 15)
                        .font(Font.pretendard(.regular, size: 17))
                        .foregroundStyle(.darkGray)
                }
                
                Spacer()

            }
            .padding(.top, 15)
            .overlay {
                
                Text("닉네임 변경")
                    .font(Font.pretendard(.semibold, size: 17))
                    .foregroundStyle(.black)
                    .padding(.top, 10)
            }
            
            HStack {
                TextFieldComponent(width: 250, placeholder: "닉네임", inputText: $newNicknameInputText)
                    .onChange(of: newNicknameInputText) { newNickname in
                        
                        if newNickname.count > 0 {
                            
                            isNicknameCheckBtnAvailable = true
                            
                        } else {
                            
                            isNicknameCheckBtnAvailable = false
                            nicknamePhrase = ""
                        }
                    }
                
                ButtonComponent(isBtnAvailable: $isNicknameCheckBtnAvailable, width: 80, btnText: "중복 확인", radius: 8, action: {
                    
                    Task {
                        
                        let result = await myPageVM.checkNicknameDuplicate(nickname: newNicknameInputText)
                        
                        isNicknamePhraseHidden = false
                        
                        if result {
                            
                            
                            isNewNicknameAvailable = true
                            
                        } else {
                         
                            isNewNicknameAvailable = false
                        }
                    }
                    
                })
            }
            .padding(.top, 10)
            
            HStack {
                Text(isNewNicknameAvailable ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다. 다른 닉네임을 입력해주세요.")
                    .font(Font.pretendard(.semibold, size: 10))
                    .padding(.top, 12)
                    .padding(.leading, 15)
                    .foregroundStyle(isNicknameCheckBtnAvailable ? .blue : .black)
                    .hidden(isNicknamePhraseHidden)
                
                Spacer()
            }
            .frame(width: screenWidth - 50)
            
            ButtonComponent(isBtnAvailable: $isRegisterBtnAvailable, width: screenWidth - 50, btnText: "변경하기", radius: 15, action: {
                
                Task {
                    
                    let result = await myPageVM.changeNickname(newNickname: newNicknameInputText)
                    
                    if result {
                        isUpdateNicknameSheetPresented = false
                    }
                    
                }
            })
            .padding(.top, 15)
            
            
            
            Spacer()
            
        }
        .onChange(of: isNewNicknameAvailable) { _ in
            
            updateRegisterBtnStatus()
            
        }
        .onDisappear {
            
            Task {
                await myPageVM.readMyProfile()
            }
            
        }
    }
    
    func updateRegisterBtnStatus() {
        
        if isNewNicknameAvailable {
            isRegisterBtnAvailable = true
        } else {
            isRegisterBtnAvailable = false
        }
        
    }
}

struct SettingComponent: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        HStack {
            Text(title)
                .font(Font.pretendard(.medium, size: 17))
            
            Spacer()
        }
        .padding(.vertical, 16)
        .frame(width: screenWidth - 40)
        .onTapGesture {
            action()
        }
    }
}


#Preview {
    SettingView(isNotificationAvailable: true, myPageVM: MyPageMainViewModel())
}
