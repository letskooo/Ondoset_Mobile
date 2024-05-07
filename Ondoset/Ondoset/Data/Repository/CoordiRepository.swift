//
//  CoordiRepository.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

final class CoordiRepository {
    
    static let shared = CoordiRepository()
    
    // 코디 기록/계획 조회
    func getCoordiRecord(getCoordiRecordDTO: GetCoordiRecordRequestDTO) async -> [GetCoordiRecordResponseDTO]? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.getCoordiRecord(data: getCoordiRecordDTO))
    }
    
    // 만족도 등록/수정
    func setSatisfaction(coordiId: Int, setSatisfactionDTO: SetSatisfactionRequestDTO) async -> SetSatisfactionResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.setSatisfaction(coordiId: coordiId, data: setSatisfactionDTO))
    }
    
    // 외출시간 등록/수정
    func setCoordiTime(coordiId: Int, setCoordiTimeDTO: SetCoordiTimeRequestDTO) async -> SetCoordiTimeResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.setCoordiTime(coordiId: coordiId, data: setCoordiTimeDTO))
    }
    
    // 코디 수정
    func putCoordi(coordiId: Int, putCoordiRequestDTO: PutCoordiRequestDTO) async -> PutCoordiResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.putCoordi(coordiId: coordiId, data: putCoordiRequestDTO))
    }
    
    // 코디 삭제
    func deleteCoordi(coordiId: Int) async -> String? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.deleteCoordi(coordiId: coordiId))
    }
    
    // 코디 이미지 등록/수정
    func setCoordiImage(coordiId: Int, image: Data) async -> SetCoordiImageResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.setCoordiImage(coordiId: coordiId, image: image))
    }
    
    // 코디 계획 등록
    func setCoordiPlan(addType: String, setCoordiPlanDTO: SetCoordiPlanRequestDTO) async -> SetCoordiPlanResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.setCoordiPlan(addType: addType, data: setCoordiPlanDTO))
    }
    
    // 과거 코디 기록 등록
    func setCoordiRecord(setCoordiRecordDTO: SetCoordiRecordRequestDTO) async -> SetCoordiRecordResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.setCoordiRecord(data: setCoordiRecordDTO))
    }
    
    // 만족도 예측
    func getSatisfactionPred(getSatisfactionPred: GetSatisfactionPredRequestDTO) async -> GetSatisfactionPredResponseDTO? {
        
        return await APIManager.shared.performRequest(endPoint: CoordiEndPoint.getSatisfactionPred(data: getSatisfactionPred))
    }
}
