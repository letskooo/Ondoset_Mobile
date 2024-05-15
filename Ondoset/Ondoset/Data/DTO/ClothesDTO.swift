//
//  ClothesDTO.swift
//  Ondoset
//
//  Created by 박민서 on 4/25/24.
//

import Foundation

struct ClothesDTO: Decodable {
    let clothesId: Int
    let name: String
    let imageURL: String?
    let category: String
    let tag: String
    let tagId: Int
    let thickness: String?
}

struct GetAllMyClothesDTO: Decodable {
    let isEOF: Bool
    let clothesList: [ClothesDTO]
}

extension ClothesDTO {
    
    func toClothes() -> Clothes? {
        guard let category = Category(rawValue: self.category.uppercased()),
              let thickness = Thickness(rawValue: self.thickness?.uppercased() ?? "적당한")
        else { return nil }
        
        return Clothes(
            clothesId: self.clothesId,
            name: self.name,
            category:  category,
            tag: self.tag,
            tagId: self.tagId,
            thickness:  thickness
        )
    }
    
    static func mockData() -> [Clothes] {
        return  [
            ClothesDTO(clothesId: 1, name: "상의1", imageURL: "image1.jpg", category: "TOP", tag: "태그1", tagId: 1, thickness: "NORMAL"),
            ClothesDTO(clothesId: 2, name: "하의1", imageURL: "image2.jpg", category: "BOTTOM", tag: "태그2", tagId: 2, thickness: "THIN"),
            ClothesDTO(clothesId: 3, name: "아우터1", imageURL: "image3.jpg", category: "OUTER", tag: "태그3", tagId: 3, thickness: "THICK"),
            ClothesDTO(clothesId: 4, name: "신발1", imageURL: "image4.jpg", category: "SHOE", tag: "태그4", tagId: 4, thickness: "NORMAL"),
            ClothesDTO(clothesId: 5, name: "악세서리1", imageURL: "image5.jpg", category: "ACC", tag: "태그5", tagId: 5, thickness: "THIN"),
            ClothesDTO(clothesId: 6, name: "상의2", imageURL: "image1.jpg", category: "TOP", tag: "태그1", tagId: 1, thickness: "NORMAL"),
            ClothesDTO(clothesId: 7, name: "하의2", imageURL: "image2.jpg", category: "BOTTOM", tag: "태그2", tagId: 2, thickness: "THIN"),
            ClothesDTO(clothesId: 8, name: "아우터2", imageURL: "image3.jpg", category: "OUTER", tag: "태그3", tagId: 3, thickness: "THICK"),
            ClothesDTO(clothesId: 9, name: "신발2", imageURL: "image4.jpg", category: "SHOE", tag: "태그4", tagId: 4, thickness: "NORMAL"),
            ClothesDTO(clothesId: 10, name: "악세서리2", imageURL: "image5.jpg", category: "ACC", tag: "태그5", tagId: 5, thickness: "THIN")
        ].compactMap { $0.toClothes() }
    }
}


// MARK: 여기서부터 추가 작성

// MARK: 날씨 예보 및 홈 카드뷰 조회

// 날씨 예보 및 홈 카드뷰 조회 요청 DTO
struct GetHomeInfoRequestDTO {
    
    let date: Int
    let lat: Double
    let lon: Double
}

struct FcstDTO: Decodable {
    
    let time: Int
    let temp: Int
    let rainP: Int
    let weather: String
}

extension FcstDTO {
    
    func toFcst() -> Fcst? {
        
        guard let weather = Weather(rawValue: self.weather) else { return nil }
        
        return Fcst(time: self.time, temp: self.temp, rainP: self.rainP, weather: weather)
    }
}

// 예보
struct ForecastDTO: Decodable {
    
    let now: Double         // 현재 기온
    let diff: Double?          // 전날 같은 시각 대비 온도차
    let feel: Double        // 체감 온도
    let weather: String     // 날씨 enum
    let min: Int?           // 최저 기온
    let max: Int?           // 최고 기온
    let fcst: [FcstDTO]
}

struct PlanDTO: Decodable {
    
    let clothesId: Int
    let name: String
    let imageURL: String?
    let category: String
    let tag: String
    let tagId: Int
    let thickness: String?
}

struct RecordDTO: Decodable {
    
    let date: Int
    let clothesList: [ClothesDTO]
}

struct RecommendDTO: Decodable {
    
    let category: String
    let tag: String
    let tagId: Int
    let thickness: String?
    let fullTag: String
}

struct OOTDShortDTO: Decodable {
    
    let imageURL: String
    let date: Int
}

// 날씨 예보 및 홈 카드뷰 조회 응답 DTO
struct GetHomeInfoResponseDTO: Decodable {
    
    let forecast: ForecastDTO
    let plan: [PlanDTO]?
    let record: [RecordDTO]
    let recommend: [[RecommendDTO]]
    let ootd: [OOTDShortDTO]
}

extension GetHomeInfoResponseDTO {
    
    func toHomeInfo() -> HomeInfo? {
        
        let forecast = Forecast(now: forecast.now, diff: forecast.diff, feel: forecast.feel, min: forecast.min, max: forecast.max, fcst: forecast.fcst.compactMap { $0.toFcst()})
        
        let plans = plan?.compactMap { plan -> Plan in
            
            if let thickness = plan.thickness {
                
                return Plan(clothesId: plan.clothesId, name: plan.name, imageURL: plan.imageURL, category: Category(rawValue: plan.category)!, tag: plan.tag, tagId: plan.tagId, thickness: Thickness(rawValue: thickness))
                
            } else {
                
                return Plan(clothesId: plan.clothesId, name: plan.name, imageURL: plan.imageURL, category: Category(rawValue: plan.category)!, tag: plan.tag, tagId: plan.tagId, thickness: nil)
            }
        }
        
        let records = record.compactMap { record -> Record in
            
            let clothesList = record.clothesList.compactMap { cloth -> Clothes in
                
                if let thickness = cloth.thickness {
                    return Clothes(clothesId: cloth.clothesId, name: cloth.name, imageURL: cloth.imageURL, category: Category(rawValue: cloth.category)!, tag: cloth.tag, tagId: cloth.tagId, thickness: Thickness(rawValue: thickness))
                } else {
                    return Clothes(clothesId: cloth.clothesId, name: cloth.name, imageURL: cloth.imageURL, category: Category(rawValue: cloth.category)!, tag: cloth.tag, tagId: cloth.tagId)
                }
            }
            
            return Record(date: record.date, clothesList: clothesList)
        }
        
        let recommends = recommend.compactMap { recommend -> [Recommend] in
            recommend.map { recom in
                if let thickness = recom.thickness {
                    
                    return Recommend(category: Category(rawValue: recom.category)!, tag: recom.tag, tagId: recom.tagId, thickness: Thickness(rawValue: thickness), fullTag: recom.fullTag)
                } else {
                    
                    return Recommend(category: Category(rawValue: recom.category)!, tag: recom.tag, tagId: recom.tagId, thickness: nil, fullTag: recom.fullTag)
                }
            }
        }
        
        let ootds = ootd.compactMap { ootd -> OOTDShort in
            
            OOTDShort(imageURL: ootd.imageURL, date: ootd.date)
        }
        
        return HomeInfo(forecast: forecast, plan: plans, record: records, recommend: recommends, ootd: ootds)
    }
}


// MARK: 옷 검색 (추천 태그)

// 옷 검색(추천 태그) 요청 DTO
struct SearchClothByTagRequestDTO {
    
    let thickness: String?
    let tagId: Int
}

struct ClothesShortDTO: Decodable {
    
    let clothesId: Int
    let name: String
    let imageURL: String?
}

// 옷 검색(추천 태그) 응답 DTO
struct SearchClothByTagResponseDTO: Decodable {
    
    // 검색 결과가 없을 경우 빈 배열이 옴
    let clothesShortList: [ClothesShortDTO]
    let coupangURL: String
}

extension SearchClothByTagResponseDTO {
    
    func toSearchedClothByTag() -> SearchedClothByTag? {
     
        let clothesShortLists = clothesShortList.compactMap { clothesShort -> ClothesShort in
            
            return ClothesShort(clothesId: clothesShort.clothesId, name: clothesShort.name, imageURL: clothesShort.imageURL)
        }
        
        return SearchedClothByTag(clothesShortList: clothesShortLists, coupangURL: coupangURL)
    }
}


// MARK: 옷 전체 조회

// 옷 전체 조회 응답 DTO
struct GetAllClothesResponseDTO: Decodable {
    
    let lastPage: Int
    let clothesList: [ClothesDTO]
}

extension GetAllClothesResponseDTO {

    func toAllClothes() -> AllClothes? {
        
        let clothesList = clothesList.compactMap { clothes in
            
            clothes.toClothes()
        }
        
        return AllClothes(lastPage: lastPage, clothesList: clothesList)
    }
}


// MARK: 카테고리별 옷 전체 조회

// 카테고리별 옷 전체 조회 요청 DTO
struct GetAllClothesByCategoryRequestDTO {
    
    let category: String
    let lastPage: Int
}

// 카테고리별 옷 전체 조회 응답 DTO
struct GetAllClothesByCategoryResponseDTO: Decodable {
    
    let lastPage: Int
    let clothesList: [ClothesDTO]
}

extension GetAllClothesByCategoryResponseDTO {
    
    func toAllClothesByCategory() -> AllClothByCategory? {
        
        let clothesList = clothesList.compactMap { clothes in
            
            clothes.toClothes()
        }
        
        return AllClothByCategory(lastPage: lastPage, clothesList: clothesList)
    }
    
}

// MARK: 옷 검색(검색어)

// 옷 검색(검색어) 요청 DTO
struct SearchClothByKeywordRequestDTO {
    
    let category: String?
    let clothesName: String
}

// 옷 검색(검색어) 응답 DTO
struct SearchClothByKeywordResponseDTO: Decodable {
    
    let clothesList: [ClothesDTO]
}

extension SearchClothByKeywordResponseDTO {
    
    func toClothesList() -> [Clothes] {
        
        let clothesList = clothesList.compactMap { clothes in
            
            clothes.toClothes()
        }
        
        return clothesList
    }
}


// MARK: 세부 태그 목록 조회

struct TagDTO: Decodable {
    
    let tag: String
    let tagId: Int
}

// 세부 태그 목록 조회 응답 DTO
struct GetTagListResponseDTO: Decodable {
    
    let top: [TagDTO]
    let bottom: [TagDTO]
    let outer: [TagDTO]
    let shoe: [TagDTO]
    let acc: [TagDTO]
}

extension GetTagListResponseDTO {
    
    func toAllTags() -> AllTags {
        
        let topTags = top.map { Tag(tag: $0.tag, tagId: $0.tagId) }
        let bottomTags = bottom.map { Tag(tag: $0.tag, tagId: $0.tagId) }
        let outerTags = outer.map { Tag(tag: $0.tag, tagId: $0.tagId) }
        let shoeTags = shoe.map { Tag(tag: $0.tag, tagId: $0.tagId) }
        let accTags = acc.map { Tag(tag: $0.tag, tagId: $0.tagId) }
        
        return AllTags(top: topTags, bottom: bottomTags, outer: outerTags, shoe: shoeTags, acc: accTags)
    }
    
}

// MARK: 옷 등록

// 옷 등록 요청 DTO
struct PostClothRequestDTO {
    
    let name: String
    let tagId: Int
    let thickness: String?
    let image: Data?
}

// 옷 등록 응답 DTO
struct PostClothResponseDTO: Decodable {
    
    let clothesId: Int
}

// MARK: 옷 수정

// 옷 수정 요청 DTO
struct PutClothRequestDTO {
    
    let clothesId: Int
    let name: String
    let tagId: Int
    let thickness: String?
    let image: Data?
}

// 옷 수정 응답 DTO
struct PutClothResponseDTO: Decodable {
    
    let clothesId: Int
}


// MARK: 옷 수정(이미지 포함X)

// 옷 수정(이미지 포함X) 요청 DTO
struct PatchClothRequestDTO {
    
    let clothesId: Int
    let name: String
    let tagId: Int
    let thickness: String?
}

// 옷 수정(이미지 포함X) 응답 DTO
struct PatchClothResponseDTO: Decodable {
    
    let clothesId: Int
}





