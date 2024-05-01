//
//  HomeMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct HomeMainView: View {
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            Text("Home")
        }
    }
}

struct SelectDateView: View {
    var body: some View {
        HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "chevron.backward")
            })
            Text("2024.03.15")
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "chevron.forward")
            })
        }
    }
}
