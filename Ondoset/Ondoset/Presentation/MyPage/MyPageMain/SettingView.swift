//
//  SettingView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import SwiftUI

struct SettingView: View {
    
    @State var profileImage: UIImage = UIImage()
    @State private var openPhoto: Bool = false
    
    @State var showAlert: Bool = false
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            
            VStack {
                
                
                Button {
                    showAlert = true
                } label: {
                    Text("로그아웃")
                }
                
                Spacer()
            }
            
            if showAlert {
                
                AlertComponent(showAlert: $showAlert, alertTitle: "로그아웃", alertContent: "정말 로그아웃 하시겠어요?", rightBtnTitle: "확인", rightBtnAction: {
                    myPageVM.logout()
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

#Preview {
    SettingView(myPageVM: MyPageMainViewModel())
}
