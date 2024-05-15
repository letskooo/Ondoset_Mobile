//
//  CoordiMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/5/24.
//

import Foundation

class CoordiMainViewModel: ObservableObject {
    
    let coordiUseCase: CoordiUseCase = CoordiUseCase.shared

    
    @Published var coordiRecord: [CoordiRecord] = []
    
    // 코디 기록/계획 조회
    func getCoordiRecord(year: Int, month: Int) async {
        
        let result = await coordiUseCase.getCoordiRecord(getCoordiRecordDTO: GetCoordiRecordRequestDTO(year: year, month: month))
        
        DispatchQueue.main.async {
            self.coordiRecord = result ?? []
        }
//        print("ViewModel: \(coordiRecord)")
    }
    
    // 만족도 등록/수정
    func setSatisfaction(coordiId: Int, satisfaction: Satisfaction) async -> Bool {
     
        let satisfaction: String = satisfaction.rawValue
        
        if let _ = await coordiUseCase.setSatisfaction(coordiId: coordiId, setSatisfactionDTO: SetSatisfactionRequestDTO(satisfaction: satisfaction)) {
            
            return true
        } else {
            return false
        }
    }
    
    // 외출 시간 등록/수정
    func setCoordiTime(coordiId: Int, lat: Double, lon: Double, region: String, departTime: Int, arrivalTime: Int) async -> Bool {
     
        guard let _ = await coordiUseCase.setCoordiTime(coordiId: coordiId, setCoordiTimeDTO: SetCoordiTimeRequestDTO(lat: lat, lon: lon, region: region, departTime: departTime, arrivalTime: arrivalTime)) else { return false }
        
        return true
    }
    
    // 코디 수정
    func putCoordi(coordiId: Int, clothes: [Int]) async -> Bool {
     
        guard let _ = await coordiUseCase.putCoordi(coordiId: coordiId, putCoordiDTO: PutCoordiRequestDTO(clothesList: clothes)) else { return false }
        
        return true
    }
    
    // 코디 삭제
    func deleteCoordi(coordi: Int) async -> Bool {
        
        guard let _ = await coordiUseCase.deleteCoordi(coordiId: coordi) else { return false }
        
        return true
    }
    
    // 코디 이미지 등록/수정
    func setCoordiImage(coordiId: Int, image: Data) async -> Bool {
     
        guard let _ = await coordiUseCase.setCoordiImage(coordiId: coordiId, image: image) else { return false }
        
        return true
    }
    
    // 코디 계획 등록
    func setCoordiPlan(addType: String, date: Int, clothesList: [Int]) async -> Bool {
        
        guard let _ = await coordiUseCase.setCoordiPlan(addType: addType, setCoordiPlanDTO: SetCoordiPlanRequestDTO(date: date, clothesList: clothesList)) else { return false }
        
        return true
    }
    
    // 과거 코디 기록 등록
    func setCoordiRecord(lat: Double, lon: Double, region: String, departTime: Int, arrivalTime: Int, clothesList: [Int]) async -> Bool {
        
        guard let _ = await coordiUseCase.setCoordiRecord(setCoordiRecordDTO: SetCoordiRecordRequestDTO(lat: lat, lon: lon, region: region, departTime: departTime, arrivalTime: arrivalTime, clothesList: clothesList)) else { return false}
        
        return true
    }
}
