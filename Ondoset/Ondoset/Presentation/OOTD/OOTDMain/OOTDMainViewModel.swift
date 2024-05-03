//
//  OOTDMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class OOTDMainViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var weatherOotdList: [OOTD] = []
    @Published var selectedWeather: Weather = .SUNNY
    @Published var selectedTempRate: TempRate = .T12
    
    var weatherLastPage: Int = -1
    
    init() {
        Task {
            await readWeatherOOTDList()
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
    
}
