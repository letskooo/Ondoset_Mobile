//
//  CoordiUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class CoordiUseCase {
    
    static let shared = CoordiUseCase()
    
    let coordRepository: CoordiRepository = CoordiRepository.shared
    
    // 코디 기록/계획 조회
    func getCoordiRecord(getCoordiRecordDTO: GetCoordiRecordRequestDTO) async -> [CoordiRecord]? {
        
        guard let coordiRecordDTO = await coordRepository.getCoordiRecord(getCoordiRecordDTO: getCoordiRecordDTO) else {
            return nil
        }
        
        return coordiRecordDTO.compactMap {$0.toCoordiRecord()}
    }
    
    // 만족도 등록/수정
    func setSatisfaction(coordiId: Int, setSatisfactionDTO: SetSatisfactionRequestDTO) async -> Bool? {
        
        guard let result = await coordRepository.setSatisfaction(coordiId: coordiId, setSatisfactionDTO: setSatisfactionDTO) else {
            return nil
        }
        
        return true
    }
    
    // 외출 시간 등록/수정
    func setCoordiTime(coordiId: Int, setCoordiTimeDTO: SetCoordiTimeRequestDTO) async -> Bool? {
        
        guard let result = await coordRepository.setCoordiTime(coordiId: coordiId, setCoordiTimeDTO: setCoordiTimeDTO) else { return nil }
        
        return true
    }
    
    // 코디 수정
    func putCoordi(coordiId: Int, putCoordiDTO: PutCoordiRequestDTO) async -> Bool? {
        
        guard let result = await coordRepository.putCoordi(coordiId: coordiId, putCoordiRequestDTO: putCoordiDTO) else { return nil }
        
        return true
    }
    
    // 코디 삭제
    func deleteCoordi(coordiId: Int) async -> Bool? {
        
        guard let result = await coordRepository.deleteCoordi(coordiId: coordiId) else { return nil }
        
        return true
    }
    
    // 코디 이미지 등록/수정
    func setCoordiImage(coordiId: Int, image: Data) async -> Bool? {
        
        guard let result = await coordRepository.setCoordiImage(coordiId: coordiId, image: image) else { return nil }
        
        return true
    }
    
    // 코디 계획 등록
    func setCoordiPlan(addType: String, setCoordiPlanDTO: SetCoordiPlanRequestDTO) async -> Bool? {
        
        guard let result = await coordRepository.setCoordiPlan(addType: addType, setCoordiPlanDTO: setCoordiPlanDTO) else { return nil }
        
        return true
    }
    
    // 과거 코디 기록 등록
    func setCoordiRecord(setCoordiRecordDTO: SetCoordiRecordRequestDTO) async -> Bool? {
        
        guard let result = await coordRepository.setCoordiRecord(setCoordiRecordDTO: setCoordiRecordDTO) else { return nil }
        
        return true
    }
    
    // 만족도 예측
    func getSatisfactionPred(getSatisfactionPredDTO: GetSatisfactionPredRequestDTO) async -> Satisfaction? {
        
        guard let result = await coordRepository.getSatisfactionPred(getSatisfactionPred: getSatisfactionPredDTO) else { return nil }
        
        return Satisfaction(rawValue: result.pred)
    }
}
