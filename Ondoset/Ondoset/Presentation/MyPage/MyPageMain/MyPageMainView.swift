//
//  MyPageMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct MyPageMainView: View {
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    MyPageMainView()
}
