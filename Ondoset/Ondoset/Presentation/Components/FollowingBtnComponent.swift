//
//  FollowingBtnComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct FollowingBtnComponent: View {
    
    @Binding var isFollowing: Bool 
    
    let action: () -> Void
    
    var body: some View {
    
        Button {
            
            action()
            
        } label: {
            Text("팔로잉")
                .font(Font.pretendard(.semibold, size: 13))
                .foregroundStyle(isFollowing ? .main : .white)
                .padding(.horizontal, 30)
                .padding(.vertical, 6)
                .background(isFollowing ? Color(hex: 0xEDEEFA) : .main)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.main)
                }
        }
    }
}

#Preview {
    FollowingBtnComponent(isFollowing: .constant(false), action: {})
}
