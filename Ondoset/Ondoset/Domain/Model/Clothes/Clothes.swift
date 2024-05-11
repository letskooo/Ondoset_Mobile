//
//  Clothes.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

struct Clothes: Equatable, Hashable {
    var clothesId: Int
    var name: String
    var imageURL: String?
    var category: Category
    var tag: String
    var tagId: Int
    var thickness: Thickness?
}

struct ClothTemplate {
    var category: Category?
    var name: String
    var searchMode: Bool = false
    var cloth: Clothes?
}

extension ClothTemplate {
    static private func convertData() -> [ClothTemplate] {
        return ClothesDTO.mockData().map { cloth in
            return ClothTemplate(
                category: cloth.category,
                name: cloth.name,
                searchMode: false,
                cloth: cloth
            )
        }
    }
    
    static func mockData() -> [ClothTemplate] {
        var mock = convertData()
        mock.append(.init(name: ""))
        return mock
    }
}


// MARK: 여기서부터 추가 작성 =============

// MARK: 날씨 예보 및 홈 카드뷰 조회

struct Fcst {
    let time: Int
    let temp: Int
    let rainP: Int
    let weather: Weather
}

extension Fcst {
    func toHourWeather() -> HourWeather {
        var inputTime = ""
        
        if self.time > 12 {
            inputTime = "오후 \(self.time - 12)시"
        } else if self.time == 12 {
            inputTime = "오후 12시"
        } else {
            inputTime = "오전 \(self.time)시"
        }
        
        return .init(
            time: inputTime,
            weather: weather.rawValue,
            temperature: temp,
            humidity: rainP
        )
    }
}

struct Forecast {
    
    let now: Double
    let diff: Double?
    let feel: Double
    let min: Int?
    let max: Int?
    let fcst: [Fcst]
}

struct Plan {
    
    let clothesId: Int
    let name: String
    let imageURL: String?
    let category: Category
    let tag: String
    let tagId: Int
    let thickness: Thickness?
}

struct Record {
    
    let date: Int
    let clothesList: [Clothes]
}

struct Recommend {
    
    let category: Category
    let tag: String
    let tagId: Int
    let thickness: Thickness?
    let fullTag: String
}

struct OOTDShort {
    
    let imageURL: String
    let date: Int
}


// 사용 모델
struct HomeInfo {
    
    let forecast: Forecast
    let plan: [Plan]?
    let record: [Record]
    let recommend: [[Recommend]]
    let ootd: [OOTDShort]
}


// MARK: 옷 검색 추천 태그

struct ClothesShort {
    
    let clothesId: Int
    let name: String
    let imageURL: String?
}

// 사용 모델
struct SearchedClothByTag {
    
    let clothesShortList: [ClothesShort]
    let coupangURL: String
}


// MARK: 옷 전체 조회

// 사용 모델
struct AllClothes {
    
    let lastPage: Int
    let ClothesList: [Clothes]
}


// MARK: 카테고리별 옷 전체 조회

// 사용 모델
struct AllClothByCategory {
    
    let lastPage: Int
    let clothesList: [Clothes]
}

// MARK: 옷 검색(검색어)

// 사용 모델
struct SearchedClothByKeyword {
    
    let clothesList: [Clothes]
}

// MARK: 세부 태그 목록 조회

struct Tag {
    
    let tag: String
    let tagId: Int
}

// 사용 모델
struct AllTags {
    
    let top: [Tag]
    let bottom: [Tag]
    let outer: [Tag]
    let shoe: [Tag]
    let acc: [Tag]
}
