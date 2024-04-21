//
//  MyPageMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct MyPageMainView: View {
    
    @StateObject var myPageVM: MyPageMainViewModel = .init()
    
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            Text("마이 페이지")
            
            Button {
                myPageVM.logout()
            } label: {
                Text("로그아웃")
            }
        }
    }
}

#Preview {
    MyPageMainView()
}
