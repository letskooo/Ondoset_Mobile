//
//  OOTDMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct OOTDMainView: View {
    
    let views: [String] = ["추천", "날씨"]
    @State var selectedView: String = "날씨"
    
    @State var openWeatherOptions: Bool = false
    @State var openTempRateOptions: Bool = false
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)

    @Namespace private var viewsNamespace
    
    @StateObject var ootdMainVM: OOTDMainViewModel = .init()
    @StateObject var ootdItemVM: OOTDItemViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        NavigationStack {
            
            VStack(spacing: 0) {
                HStack {
                    ForEach(views, id: \.self) { view in
                        
                        ZStack {
                            
                            if selectedView == view {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.main)
                                    .matchedGeometryEffect(id: "view", in: viewsNamespace)
                                    .frame(width: 60, height: 2)
                                    .offset(y: 15)
                            }
                            
                            Text(view)
                                .foregroundStyle(selectedView == view ? .main : .darkGray)
                                .font(Font.pretendard(.medium, size: 17))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedView = view
                            }
                        }
                    }
                    Spacer()
                }
                
                TabView(selection: $selectedView) {
                    
                    /// 추천 뷰
                    ScrollView {
                        
                        Text("추천")
                        
                    }
                    .tag("추천")
                    
                    /// 날씨 뷰
                    
                    ZStack(alignment: .top) {
                        
                        ScrollView(showsIndicators: false) {
                            
                            LazyVGrid(columns: columns, spacing: 1) {
                                
                                let ootdList = ootdMainVM.weatherOotdList
                                
                                ForEach(ootdList.indices, id: \.self) { index in

                                    let dateString = DateFormatter.string(epoch: ootdList[index].date)
                                    
                                    NavigationLink(destination: OOTDItemView(ootdId: ootdList[index].ootdId, ootdImageURL: ootdList[index].imageURL, dateString: dateString, lowestTemp: ootdList[index].lowestTemp, highestTemp: ootdList[index].highestTemp)) {
                                        OOTDComponent(date: dateString, minTemp: ootdList[index].lowestTemp, maxTemp: ootdList[index].highestTemp, ootdImageURL: ootdList[index].imageURL)
                                        .frame(width: screenWidth / 2)
                                    }
                                    .onAppear {
                                        
                                        if index == ootdList.count - 1 {
                                            Task {
                                                await ootdMainVM.readWeatherOOTDList()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.top, 60)
                            
                        }
                        .onChange(of: ootdMainVM.selectedWeather) { weather in
                            
                            ootdMainVM.weatherOotdList = []
                            ootdMainVM.weatherLastPage = -1
                            
                            Task {
                                await ootdMainVM.readWeatherOOTDList()
                            }
                        }
                        .onChange(of: ootdMainVM.selectedTempRate) { tempRate in
                            
                            ootdMainVM.weatherOotdList = []
                            ootdMainVM.weatherLastPage = -1
                            
                            Task {
                                await ootdMainVM.readWeatherOOTDList()
                            }
                            
                        }
                        
                        VStack {
                            
                            HStack(alignment: .top, spacing: 12) {

                                VStack {
                                    
                                    Button {
                                        
                                        withAnimation(.spring()) {
                                            openWeatherOptions.toggle()
                                        }
                                        
                                    } label: {
                                        ootdMainVM.selectedWeather.imageWhite
                                            .frame(width: 34, height: 34)
                                            .background(.main)
                                            .cornerRadius(50)
                                    }
                                    
                                    if openWeatherOptions {
                                        
                                        weatherListView
                                    }
                                }
                                
                                VStack {
                                    
                                    Button {

                                        withAnimation(.spring()) {
                                            openTempRateOptions.toggle()
                                        }

                                    } label: {

                                        Text("\(ootdMainVM.selectedTempRate.section)")
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(.main)
                                            .cornerRadius(50)
                                    }
                                    
                                    if openTempRateOptions {
                                        
                                        tempRateListView
                                    }
                                }

                                Spacer()
                            }
                            .padding(.leading, 30)
                            .padding(.vertical, 15)
                            
                            Spacer()
                            
                            HStack {
                                
                                Spacer()
                                
                                NavigationLink(destination: AddOOTDView()) {
                                    
                                    Image("addMainButton")
                                        .padding(.trailing, 10)
                                        .padding(.bottom, 30)
                                }
                            }
                        }
                    }
                    .tag("날씨")
                    .padding(.bottom, screenHeight / 18)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()
            }
            .onAppear {
                wholeVM.isTabBarHidden = false
            }
        }
    }
    
    private var weatherListView: some View {
        
        VStack(spacing: 5) {
            
            ForEach(Weather.allCases, id: \.self) { weather in
                
                Button {
                    
                    ootdMainVM.selectedWeather = weather
                    
                    openWeatherOptions = false
                    
                } label: {
                    weather.imageWhite
                        .frame(width: 34, height: 34)
                        .background(.mainLight)
                        .cornerRadius(50)
                }
                
            }
        }
    }
    
    private var tempRateListView: some View {
        
        VStack(spacing: 5) {
         
            ForEach(TempRate.allCases, id: \.self) { tempRate in
                
                Button {
                    
                    ootdMainVM.selectedTempRate = tempRate
                    
                    openTempRateOptions = false
                    
                } label: {
                    
                    Text("\(tempRate.section)")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.mainLight)
                        .cornerRadius(50)
                }
                
            }
        }
    }
}

#Preview {
    OOTDMainView()
}
