//
//  HomeMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct HomeMainView: View {
    
    @StateObject var homeMainVM: HomeMainViewModel = .init()
    
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    WeatherView()
                        .environmentObject(homeMainVM)
                    HomeBottomView()
                        .environmentObject(homeMainVM)
                    Rectangle()
                        .frame(height: 44)
                        .foregroundStyle(.white)
                }
                
                if homeMainVM.isHomeInfoFetching {
                    Color.white.opacity(0.3)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mainLight))
                        .scaleEffect(2.0, anchor: .center)
                }
            }
        }
        .onAppear(perform: {
            homeMainVM.homeViewDate = .now
        })
        .sheet(isPresented: $homeMainVM.presentAIRecomm) {
            NavigationView { AICoordiRecommendView(viewType: homeMainVM.presentSheetViewType, AICoordiRecommendVM: .init(clothesData: homeMainVM.selectedClothTemplates ?? [.init(name: "")])) }
        }
    }
}


#Preview {
    HomeMainView()
}
