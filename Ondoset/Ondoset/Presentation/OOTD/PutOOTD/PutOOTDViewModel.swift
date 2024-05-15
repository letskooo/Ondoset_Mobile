//
//  PutOOTDViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import Foundation

class PutOOTDViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    let coordiUseCase: CoordiUseCase = CoordiUseCase.shared
    
    // 기존 OOTD 내용
    @Published var getOOTDforPut: GetOOTDforPut = GetOOTDforPut(ootdId: 0, region: "", departTime: 0, arrivalTime: 0, weather: .CLOUDY, lowestTemp: 0, highestTemp: 0, imageURL: "", wearingList: [])
    
    
    // 새로 입력되는 내용들
    @Published var ootdRegion: String = ""
    @Published var ootdDepartTime: Int = 0
    @Published var ootdArrivalTime: Int = 0
    @Published var ootdWeather: String = ""
    @Published var ootdLowestTemp: Int = 0
    @Published var ootdHighestTemp: Int = 0
    @Published var ootdImage: Data = Data()
    @Published var ootdWearingList: [String] = []
    
    @Published var dailyCoordi: [CoordiRecord] = []
    
    // 등록하기 버튼 활성화 여부
    @Published var isRegisterBtnAvailable: Bool = false
    
    // 추가할 옷 이름 텍스트 필드 내용
    @Published var addClothInputText: String = ""
    
    // 추가한 옷 목록
    @Published var addClothesList: [String] = []
    
    
    // OOTD 수정용 조회
    func getOOTDforPut(ootdId: Int) async {
        
        if let result = await ootdUseCase.getOOTDforPut(ootdId: ootdId) {
            
            print("OOTD 수정용 조회: \(result)")
            
            DispatchQueue.main.async {
                
                self.getOOTDforPut = result
            }
            
            for i in result.wearingList {
                
                print("옷: \(i)")
                
            }
        }
    }
    
    // OOTD 수정
    func putOOTD(ootdId: Int, isOOTDImageSelected: Bool) async -> Bool {
        
        var imageData: Data? = nil
        
        if isOOTDImageSelected {
            
            imageData = ootdImage
        }
        
        let result = await ootdUseCase.putOOTD(ootdId: ootdId, putOOTDDTO: PutOOTDRequestDTO(region: ootdRegion, departTime: ootdDepartTime, arrivalTime: ootdArrivalTime, weather: ootdWeather, lowestTemp: ootdLowestTemp, highestTemp: ootdHighestTemp, image: imageData, wearingList: ootdWearingList))
        
        return result
    }
    
    // OOTD 등록될 날씨 미리보기
    func getOOTDWeather(lat: Double, lon: Double, departTime: Int, arrivalTime: Int, location: String) async {
     
        // 추후에 여기에 지역 검색 후 위도 및 경도, 외출 출발 및 도착 시간을 저장하고
        // 아래 메소드에 파라미터로 보내는 코드가 추가되어야 합니다.
        // if let result = await ootdUseCase.getOOTDWeather()
        
        // 그냥 변환되는 EpochTime은 영국 시간 기준이고 한국 꺼는 변환된 것에서 32400을 빼야함
        
        if let result = await ootdUseCase.getOOTDWeather(data: GetOOTDWeatherRequestDTO(lat: lat, lon: lon, departTime: departTime, arrivalTime: arrivalTime)) {
            
            ootdWeather = result.weather
            ootdLowestTemp = result.lowestTemp
            ootdHighestTemp = result.highestTemp
            
            ootdRegion = location
            
            print("=====뷰모델 날씨 미리보기======")
            print("지역 이름: \(ootdRegion)")
            print(ootdWeather)
            print(ootdLowestTemp)
            print(ootdHighestTemp)
            
        }
    }
 
    // 코디 하루 조회
    func getDailyCoordi(year: Int, month: Int, day: Int) async {
        
        if let result = await coordiUseCase.getDailyCoordi(getDailyCoordiDTO: GetDailyCoordiRequestDTO(year: year, month: month, day: day)) {
            
            dailyCoordi = result
            
        } else {
            
            dailyCoordi = []
        }
        
    }
}
