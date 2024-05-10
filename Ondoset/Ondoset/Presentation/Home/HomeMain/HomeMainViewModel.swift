//
//  HomeMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation
import CoreLocation

final class HomeMainViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    // Common Datas
    @Published var homeViewDate: Date = .now
    @Published var homeViewLocate: CLLocationCoordinate2D = .init(latitude: 37.4551254, longitude: 127.1334847) // 걍 서울
    
    // WeatherView Datas
    /// 전날 같은 시각 대비 기온 변화
    @Published var weatherTempDiff: Int? = nil
    /// 체감온도
    @Published var weatherFeelingTemp: Double = 0.0
    /// 최저기온
    @Published var weatherMinTemp: Int? = nil
    /// 최고기온
    @Published var weatherMaxTemp: Int? = nil
    /// 현재기온
    @Published var weatherNowTemp: Double = 0.0
    /// 예보목록
    @Published var weahterForecasts: [Fcst] = []
    
    // BottomView Datas
    
    init() {
        Task {
//            await self.getWeatherInfo()
            self.mockFetchWeatherInfo()
        }
    }
}

// MARK: Interface Functions
extension HomeMainViewModel {
    func changeDate(with num: Int) {
        self.homeViewDate = self.homeViewDate.changeNDay(with: num)
    }
}

// MARK: Internal Functions
extension HomeMainViewModel {
    
    private func getDateIntVal(from date: Date) -> Int {
        let now = date.timeIntervalSince1970 // 현재 시간을 초 단위로 가져옴
        let date = ((now + 32400) / 86400) * 86400 - 32400 // 식 계산
        let intDate = Int(date)
        return intDate
    }
    
    private func mockFetchWeatherInfo() {
        weatherTempDiff = 2
        // 체감온도
        weatherFeelingTemp = 12.9
        // 최저기온
        weatherMinTemp = 5
        // 최고기온
        weatherMaxTemp = 14
        // 현재기온
        weatherNowTemp = 10.0
        // 예보목록
        weahterForecasts = []
    }
    
    private func getWeatherInfo() async {
//        print(GetHomeInfoRequestDTO(date: getDateIntVal(from: homeViewDate), lat: homeViewLocate.latitude, lon: homeViewLocate.longitude))
        
        if let result = await clothesUseCase.getHomeInfo(
            getHomeInfoDTO: .init(
                date: getDateIntVal(from: homeViewDate),
                lat: homeViewLocate.latitude,
                lon: homeViewLocate.longitude
            )
        ) {
//            print(result.forecast)
            // 전날 같은 시각 대비 기온 변화
            weatherTempDiff = result.forecast.diff
            // 체감온도
            weatherFeelingTemp = result.forecast.feel
            // 최저기온
            weatherMinTemp = result.forecast.min
            // 최고기온
            weatherMaxTemp = result.forecast.max
            // 현재기온
            weatherNowTemp = result.forecast.now
            // 예보목록
            weahterForecasts = result.forecast.fcst
        }
    }
}
