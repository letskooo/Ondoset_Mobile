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
    @Published var weatherTempDiff: Double? = nil
    /// 체감온도
    @Published var weatherFeelingTemp: Double = 0.0
    /// 최저기온
    @Published var weatherMinTemp: Int? = nil
    /// 최고기온
    @Published var weatherMaxTemp: Int? = nil
    /// 현재기온
    @Published var weatherNowTemp: Double = 0.0
    /// 예보목록
    @Published var weahterForecasts: [HourWeather] = []
    
    // BottomView Datas
    /// 오늘 등록된 코디 계획
    @Published var coordiPlan: [Plan]? = nil
    /// 오늘과 비슷한 과거의 코디 기록
    @Published var similRecord: [Record] = []
    /// AI 추천 오늘 코디
    @Published var recommendAI: [[Recommend]] = []
    /// 오늘과 비슷한 날씨의 타인 OOTD
    @Published var othersOOTD: [OOTDShort] = []
    
    init() {
        Task {
            await self.getHomeInfo()
//            self.mockFetchWeatherInfo()
        }
    }
}

// MARK: Interface Functions
extension HomeMainViewModel {
    func changeDate(with num: Int) {
        self.homeViewDate = self.homeViewDate.changeNDay(with: num)
    }
    
    func getDate(from intValue: Int) -> Date? {
        let seconds = TimeInterval(intValue)
        let date = Date(timeIntervalSince1970: seconds)
        return date
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
        weahterForecasts = [
            Fcst.init(time: 1, temp: 11, rainP: 15, weather: .CLOUDY),
            Fcst.init(time: 2, temp: 11, rainP: 15, weather: .CLOUDY),
            Fcst.init(time: 3, temp: 10, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 4, temp: 11, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 5, temp: 13, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 6, temp: 11, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 7, temp: 15, rainP: 15, weather: .PARTLY_CLOUDY),
            Fcst.init(time: 8, temp: 16, rainP: 15, weather: .PARTLY_CLOUDY),
            Fcst.init(time: 9, temp: 18, rainP: 15, weather: .PARTLY_CLOUDY),
            Fcst.init(time: 10, temp: 19, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 11, temp: 21, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 12, temp: 23, rainP: 15, weather: .SUNNY),
            Fcst.init(time: 13, temp: 25, rainP: 15, weather: .CLOUDY)
        ].map { $0.toHourWeather()}
    }
    
    private func getHomeInfo() async {
//        print(GetHomeInfoRequestDTO(date: getDateIntVal(from: homeViewDate), lat: homeViewLocate.latitude, lon: homeViewLocate.longitude))
        
        if let result = await clothesUseCase.getHomeInfo(
            getHomeInfoDTO: .init(
                date: getDateIntVal(from: homeViewDate),
                lat: homeViewLocate.latitude,
                lon: homeViewLocate.longitude
            )
        ) {
//            print(result.forecast)
            DispatchQueue.main.async {
                // 전날 같은 시각 대비 기온 변화
                self.weatherTempDiff = result.forecast.diff
                // 체감온도
                self.weatherFeelingTemp = result.forecast.feel
                // 최저기온
                self.weatherMinTemp = result.forecast.min
                // 최고기온
                self.weatherMaxTemp = result.forecast.max
                // 현재기온
                self.weatherNowTemp = result.forecast.now
                // 예보목록
                self.weahterForecasts = result.forecast.fcst.map {$0.toHourWeather()}
                
                // BottomData
                self.coordiPlan = result.plan
                self.similRecord = result.record
                self.recommendAI = result.recommend
                self.othersOOTD = result.ootd
            }
            
        }
    }
}
