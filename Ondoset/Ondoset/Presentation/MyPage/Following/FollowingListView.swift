//
//  FollowingListView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct FollowingListView: View {
    
    @State var searchText: String = ""
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    SearchBarComponent(searchText: $searchText, placeHolder: "닉네임을 검색하세요") { _ in
                        
                        
                        
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 5)
                    
                    Rectangle()
                        .frame(width: screenWidth, height: 1)
                        .foregroundStyle(Color(hex: 0xEDEEFA))
                        .padding(.top, 18)
                }
            }
        }
        .navigationTitle("팔로잉한 계정")
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
    FollowingListView(myPageVM: MyPageMainViewModel())
}
