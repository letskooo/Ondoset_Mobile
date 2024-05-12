//
//  CoordiDTO.swift
//  Ondoset
//
//  Created by KoSungmin on 5/5/24.
//

import Foundation

// 코디 기록/계획 조회 요청 DTO
struct GetCoordiRecordRequestDTO: Encodable {
    
    let year: Int
    let month: Int
}

// 코디 기록/계획 조회 응답 DTO
struct GetCoordiRecordResponseDTO: Decodable {
    
    let coordiId: Int
    let year: Int
    let month: Int
    let day: Int
    let satisfaction: String?
    let departTime: Int?
    let arrivalTime: Int?
    let weather: String?
    let lowestTemp: Int?
    let highestTemp: Int?
    let imageURL: String?
    let clothesList: [ClothesDTO]
}

extension GetCoordiRecordResponseDTO {
    
    func toCoordiRecord() -> CoordiRecord {
        
        if let image = self.imageURL {
            
            let coordiImageURL: String? = "\(Constants.serverURL)/images\(image)"

            return CoordiRecord(coordiId: self.coordiId, year: self.year, month: self.month, day: self.day, satisfaction: Satisfaction(rawValue: self.satisfaction ?? ""), departTime: self.departTime, arrivalTime: self.arrivalTime, weather: Weather(rawValue: self.weather ?? ""), lowestTemp: self.lowestTemp, highestTemp: self.highestTemp, imageURL: coordiImageURL, clothesList: self.clothesList.compactMap { $0.toClothes()})
        } else {
            return CoordiRecord(coordiId: self.coordiId, year: self.year, month: self.month, day: self.day, satisfaction: Satisfaction(rawValue: self.satisfaction ?? ""), departTime: self.departTime, arrivalTime: self.arrivalTime, weather: Weather(rawValue: self.weather ?? ""), lowestTemp: self.lowestTemp, highestTemp: self.highestTemp, imageURL: nil, clothesList: self.clothesList.compactMap { $0.toClothes()})
        }   
    }
}

// 코디 만족도 등록/수정 요청 DTO
struct SetSatisfactionRequestDTO: Encodable {
    
    let satisfaction: String
}

// 코디 만족도 등록/수정 응답 DTO
struct SetSatisfactionResponseDTO: Decodable {
    
    let date: Int
}

// 코디 외출 시간 등록/수정 요청 DTO
struct SetCoordiTimeRequestDTO: Encodable {
    
    let lat: Double
    let lon: Double
    let departTime: Int
    let arrivalTime: Int
}

// 코디 외출 시간 등록/수정 응답 DTO
struct SetCoordiTimeResponseDTO: Decodable {
    
    // 이건 추후에 얘기해보자
    let date: Int
}

// 코디 수정 요청 DTO
struct PutCoordiRequestDTO: Encodable {
    
    let clothesList: [Int]
}

// 코디 수정 응답 DTO
struct PutCoordiResponseDTO: Decodable {
    
    let date: Int
}

// 코디 이미지 등록/수정 응답 DTO
struct SetCoordiImageResponseDTO: Decodable {
    
    let date: Int
}

// 코디 계획 등록 요청 DTO
struct SetCoordiPlanRequestDTO: Encodable {
    
    let date: Int
    let clothesList: [Int]
}

// 코디 계획 등록 응답 DTO
struct SetCoordiPlanResponseDTO: Decodable {
    
    let date: Int
}

// 과거 코디 기록 요청 DTO
struct SetCoordiRecordRequestDTO: Encodable {
    
    let lat: Double
    let lon: Double
    let departTime: Int
    let arrivalTime: Int
    let clothesList: [Int]
}

// 과거 코디 기록 응답 DTO
struct SetCoordiRecordResponseDTO: Decodable {
    
    let saved: Bool // 등록하는 시점이 아직 오늘이 안 지났는지의 여부. true면 외출 시간이 잘 등록된 것. false면 등록 안 되어서 나중에 등록해달라고 안내가 나가야 함.
    let date: Int
}

struct TagCombination: Encodable {
    
    let tagId: Int
    let thickness: String?
}

// 만족도 예측 요청 DTO
struct GetSatisfactionPredRequestDTO: Encodable {
    
    let tagComb: [TagCombination]
}

// 만족도 예측 응답 DTO
struct GetSatisfactionPredResponseDTO: Decodable {
    
    let pred: String
}
