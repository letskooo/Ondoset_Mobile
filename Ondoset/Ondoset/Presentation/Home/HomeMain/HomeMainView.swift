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
                    .foregroundStyle(.darkGray)
            })
            Text("2024.03.15")
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.darkGray)
            })
        }
    }
}

struct WeatherHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "scope")
                    .padding()
                Spacer()
                SelectDateView()
                Spacer()
                Image(systemName: "mappin.and.ellipse")
                    .padding()
            }
        }
    }
}

#Preview {
    WeatherHeaderView()
}
