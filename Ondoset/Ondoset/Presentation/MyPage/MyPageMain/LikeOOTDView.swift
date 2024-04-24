//
//  LikeOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct LikeOOTDView: View {
    
    @ObservedObject var myPageVM: MyPageMainViewModel
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)
    
    var body: some View {
        ScrollView {
            
            
            
            
        }
        .navigationTitle("공감한 OOTD")
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
    LikeOOTDView(myPageVM: MyPageMainViewModel())
}
