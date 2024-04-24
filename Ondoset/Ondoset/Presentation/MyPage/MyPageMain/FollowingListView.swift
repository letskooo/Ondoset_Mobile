//
//  FollowingListView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct FollowingListView: View {
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            ScrollView {
                
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
