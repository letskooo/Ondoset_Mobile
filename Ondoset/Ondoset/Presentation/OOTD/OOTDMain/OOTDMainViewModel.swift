//
//  OOTDMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class OOTDMainViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var recommendOotdList: [OOTD] = []
    @Published var weatherOotdList: [OOTD] = []
    @Published var selectedWeather: Weather = .SUNNY
    @Published var selectedTempRate: TempRate = .T12
    
    var recommendLastPage: Int = -1
    var weatherLastPage: Int = -1
    
    init() {
        Task {
            await readWeatherOOTDList()
            await getRecommendOOTDList()
        }
    }
    
    // 추천 OOTD 조회
    func getRecommendOOTDList() async {
        
        if recommendLastPage != 2 {
            
            if let result = await ootdUseCase.getRecommendOOTDList(lastPage: recommendLastPage) {
                
                DispatchQueue.main.async {
                    
                    self.recommendOotdList.append(contentsOf: result.ootdList)
                    
                    self.recommendLastPage = result.lastPage
                    
                }
            }
        }
    }
    
    // 날씨 OOTD 조회
    func readWeatherOOTDList() async {
        
        if weatherLastPage != -2 {
            
            if let result = await ootdUseCase.readWeatherOOTDList(data: ReadWeatherOOTDRequestDTO(weather: selectedWeather.rawValue, tempRate: selectedTempRate.stringValue, lastPage: weatherLastPage)) {
                
                DispatchQueue.main.async {
                    
                    self.weatherOotdList.append(contentsOf: result.ootdList)
                    
                    self.weatherLastPage = result.lastPage
                }
            }
        }
    }
    
    // OOTD 기능 제한 확인
    func getBanPeriod() async -> Int {
        
        if let result = await ootdUseCase.getBanPeriod() {
            
            print("금지 기간: \(result)")
            
            return result
            
        } else {
            
            return -3
        }
    }
}
