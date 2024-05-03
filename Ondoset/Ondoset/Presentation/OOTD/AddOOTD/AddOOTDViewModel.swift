//
//  RegisterOOTDViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/26/24.
//

import Foundation

class AddOOTDViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
//    @Published var addOOTD: AddOOTD?
    @Published var ootdDepartTime: Int = 0
    @Published var ootdArrivalTime: Int = 0
    @Published var ootdWeather: String = ""
    @Published var ootdLowestTemp: Int = 0
    @Published var ootdHighestTemp: Int = 0
    @Published var ootdImage: Data = Data()
    @Published var ootdWearingList: [String] = []
    
    // 등록하기 버튼 활성화 여부
    @Published var isRegisterBtnAvailable: Bool = false
    
    // 추가할 옷 이름 텍스트 필드 내용
    @Published var addClothInputText: String = ""
    
    // 추가한 옷 목록
    @Published var addClothesList: [String] = []
    
    
    // OOTD 등록될 날씨 미리보기
    func getOOTDWeather() async {
     
        // 추후에 여기에 지역 검색 후 위도 및 경도, 외출 출발 및 도착 시간을 저장하고
        // 아래 메소드에 파라미터로 보내는 코드가 추가되어야 합니다.
        // if let result = await ootdUseCase.getOOTDWeather()
        
        // 그냥 변환되는 EpochTime은 영국 시간 기준이고 한국 꺼는 변환된 것에서 32400을 빼야함
        
        
        if let result = await ootdUseCase.getOOTDWeather(data: GetOOTDWeatherRequestDTO.mockData()) {
            
            self.ootdWeather = result.weather
            self.ootdLowestTemp = result.lowestTemp
            self.ootdHighestTemp = result.highestTemp
            
            print("네트워크 결과")
            print(result.weather)
            print(result.lowestTemp)
            print(result.highestTemp)
            
            print("뷰모델 저장 결과")
            print(ootdWeather)
            print(ootdHighestTemp)
            print(ootdLowestTemp)
        }
    }
    
    // OOTD 등록
    func registerOOTD() async -> Bool {
        
        let result = await ootdUseCase.registerOOTD(data: PostOOTDRequestDTO(departTime: ootdDepartTime, arrivalTime: ootdArrivalTime, weather: ootdWeather, lowestTemp: ootdLowestTemp, highestTemp: ootdHighestTemp, image: ootdImage, wearingList: ootdWearingList))
        
        print(ootdDepartTime)
        print(ootdArrivalTime)
        print(ootdWeather)
        print(ootdLowestTemp)
        print(ootdHighestTemp)
        print("====")
        print(ootdImage)
        print(ootdWearingList)
        
        return result
    }
}
