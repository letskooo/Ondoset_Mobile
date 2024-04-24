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
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
        
            Button {
                
                self.openPhoto = true
                
            } label: {
                Text("이미지 불러오기")
            }
            
            Image(uiImage: self.profileImage)
                .resizable()
                .frame(minWidth: 96, maxWidth: 96)
                .scaledToFit()
                .clipShape(Circle())
            
            Spacer()
            
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
