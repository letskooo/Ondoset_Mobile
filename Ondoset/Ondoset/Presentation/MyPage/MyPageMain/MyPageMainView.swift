//
//  MyPageMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct MyPageMainView: View {
    
    @StateObject var myPageVM: MyPageMainViewModel = .init()
    
    @State var showAlert: Bool = false
    
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            
            ZStack {
                VStack {
                    Text("마이 페이지")
                    
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
        }
    }
}

#Preview {
    MyPageMainView()
}
