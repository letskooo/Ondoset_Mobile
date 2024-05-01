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

struct WeatherMainView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(spacing: 15) {
                // 상단 전날 온도 차이 표시
                HStack(spacing: 0) {
                    Text("어제보다 ")
                        .font(.pretendard(.medium, size: 15))
                    Text("-4°C")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(.min)
                }
                // 중간 큰 온도 표시
                HStack(alignment: .top, spacing: 0) {
                    Text("4")
                        .font(.pretendard(.bold, size: 50))
                    Text("°C")
                        .font(.pretendard(.medium, size: 25))
                        .padding(.top, 5)
                }
                // 하단 체감 온도 표시
                Text("체감온도 3°C")
                    .font(.pretendard(.medium, size: 15))
                
            }
            Spacer()
            Image(uiImage: .weatherSunny)
            Spacer()
        }
        .overlay {
            Text("제공: 기상청")
                .font(.pretendard(.medium, size: 10))
                .foregroundStyle(.darkGray)
                .offset(x: 160, y: 80)
        }
        .padding()
        .background(Color.sub1Light)
    }
}

#Preview {
    WeatherMainView()
}
