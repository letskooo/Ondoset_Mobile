//
//  WeatherView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

// MARK: WeatherView
struct WeatherView: View {
    
    var body: some View {
        VStack(spacing: 0){
            WeatherHeaderView()
            WeatherMainView()
            WeatherFooterView()
        }
    }
    
    // MARK:  SelectDateView
    /// WeatherHeaderView에 들어가는 날짜 선택 뷰
    struct SelectDateView: View {
        
        @EnvironmentObject var homeMainVM: HomeMainViewModel
        
        var body: some View {
            HStack {
                Button(action: {
                    homeMainVM.changeDate(with: -1)
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.darkGray)
                })
                Text("\(DateFormatter.dateOnly.string(from: homeMainVM.homeViewDate))")
                Button(action: {
                    homeMainVM.changeDate(with: 1)
                }, label: {
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.darkGray)
                })
            }
        }
    }
    
    // MARK: WeatherHeaderView
    struct WeatherHeaderView: View {
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    // TODO: 지도 관련 로직 추가 된 후 비즈니스 로직 작성
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
    
    // MARK: WeatherMainView
    struct WeatherMainView: View {
        
        @EnvironmentObject var homeMainVM: HomeMainViewModel
        
        var body: some View {
            HStack(alignment: .center) {
                Spacer()
                VStack(spacing: 15) {
                    // 상단 전날 온도 차이 표시
                    if let diff = homeMainVM.weatherTempDiff {
                        HStack(spacing: 0) {
                            Text("어제보다 ")
                                .font(.pretendard(.medium, size: 15))
                            Text("\(diff)°C")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundStyle(diff > 0 ? .max : .min)
                        }
                    } else {
                        Spacer(minLength: 10)
                    }
                    // 중간 큰 온도 표시
                    HStack(alignment: .top, spacing: 0) {
                        Text("\(String(format: "%.0f", round(homeMainVM.weatherNowTemp)))")
                            .font(.pretendard(.bold, size: 50))
                        Text("°C")
                            .font(.pretendard(.medium, size: 25))
                            .padding(.top, 5)
                    }
                    // 하단 체감 온도 표시
                    Text("체감온도 \(String(format: "%.0f", round(homeMainVM.weatherFeelingTemp)))°C")
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
    
    // MARK: HourlyWeatherView
    /// WeatherFooterView에 들어가는 당일 날씨 뷰
    struct HourlyWeatherView: View {
        
        let hourlyWeather: [HourWeather] = [
            .init(time: "오전 9시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오전 10시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오전 11시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 12시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 1시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 2시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 3시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 4시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 5시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 6시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 7시", weather: "SUNNY", temperature: 6, humidity: 0),
            .init(time: "오후 8시", weather: "SUNNY", temperature: 6, humidity: 0),
        ]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourlyWeather, id: \.self) { item in
                        VStack {
                            Text(item.time)
                                .font(.pretendard(.medium, size: 10))
                            Image(Weather.getType(from: item.weather)?.smallImage ?? .cloudyMain)
                                .renderingMode(.template)
                                .foregroundStyle(.black)
                            Text("\(item.temperature)°C")
                                .font(.pretendard(.bold, size: 13))
                                .padding(1)
                            Text("\(item.humidity)%")
                                .font(.pretendard(.medium, size: 10))
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: WeatherFooterView
    struct WeatherFooterView: View {
        // state
        @State var isFold: Bool = true
        @EnvironmentObject var homeMainVM: HomeMainViewModel
        
        var body: some View {
            VStack(spacing: 0) {
                // lev1 - 일교차 + 폴드 버튼
                HStack {
                    // 일교차
                    if let minTemp = homeMainVM.weatherMinTemp, let maxTemp = homeMainVM.weatherMaxTemp {
                        HStack(spacing: 0) {
                            Text("\(minTemp)°C")
                                .font(.pretendard(.bold, size: 13))
                                .foregroundStyle(.min)
                            Text(" / ")
                                .font(.pretendard(.medium, size: 13))
                            Text("\(maxTemp)°C")
                                .font(.pretendard(.bold, size: 13))
                                .foregroundStyle(.max)
                        }
                        .padding()
                    }
                    
                    Spacer()
                    Button(action: {
                        isFold.toggle()
                    }, label: {
                        Image(systemName: isFold ? "chevron.down" : "chevron.up")
                            .foregroundStyle(.main)
                    })
                    .padding()
                }
                Divider()
                    .frame(height: 2)
                    .overlay(Color.ondosetBackground)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                if !isFold {
                    // lev2 - 주간 날씨
                    HourlyWeatherView()
                }
            }
        }
    }
}
