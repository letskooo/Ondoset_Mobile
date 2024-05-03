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
    
    @State var logOutShowAlert: Bool = false
    @State var withdrawShowAlert: Bool = false
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
    
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    
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
                    
                    Text(myPageVM.memberProfile?.username ?? "사용자 아이디")
                        .font(Font.pretendard(.medium, size: 13))
                        .padding(.top, 16)
                    
                    Text(myPageVM.memberProfile?.nickname ?? "사용자 닉네임")
                        .font(Font.pretendard(.medium, size: 15))
                        .padding(.top, 10)
                        .overlay {
                            Image("pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 14, height: 14)
                                .padding(.leading, 7)
                                .offset(x: 33, y: 3)
                        }
                        .onTapGesture {
                            
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
