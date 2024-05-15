//
//  OotdDTO.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import Foundation

struct OOTDDTO: Decodable {
    
    let ootdId: Int
    let date: Int
    let lowestTemp: Int
    let highestTemp: Int
    let imageURL: String
}

extension OOTDDTO {
    func toOOTD() -> OOTD {
        return OOTD(ootdId: self.ootdId, date: self.date, lowestTemp: self.lowestTemp, highestTemp: self.highestTemp, imageURL: "\(Constants.serverURL)/images\(self.imageURL)")
    }
}

// 내 프로필 조회 응답 DTO
struct ReadProfileResponseDTO: Decodable {
    
    let username: String
    let nickname: String
    let profileImage: String?
    let ootdCount: Int
    let likeCount: Int
    let followingCount: Int
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadProfileResponseDTO {
    
    func toMemberProfile() -> MemberProfile {
        
        let ootds = self.ootdList.map { $0.toOOTD() }
        let imageURL: String? = self.profileImage != nil ? "\(Constants.serverURL)/images\(self.profileImage!)" : nil
        
        return MemberProfile(username: self.username, nickname: self.nickname, profileImage: imageURL, ootdList: ootds, ootdCount: self.ootdCount, likeCount: self.likeCount, followingCount: self.followingCount)
    }
}

// 내 프로필 페이징 응답 DTO
struct MyProfilePagingResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension MyProfilePagingResponseDTO {
    
    func toOOTD() -> [OOTD] {
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}

// 공감한 OOTD 조회 응답 DTO
struct ReadLikeOOTDListResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadLikeOOTDListResponseDTO {
    
    func toOOTD() -> [OOTD] {
     
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}

struct FollowingDTO: Decodable {
    
    let memberId: Int
    let nickname: String
    let imageURL: String?
    let isFollowing: Bool
    let ootdCount: Int
}

extension FollowingDTO {
    
    func toFollowing() -> Following {
        return Following(memberId: self.memberId, nickname: self.nickname, imageURL: self.imageURL, isFollowing: self.isFollowing, ootdCount: self.ootdCount)
    }
}

// 팔로잉 목록 조회 응답 DTO
struct ReadFollowingListResponseDTO: Decodable {
    
    let lastPage: Int
    let followingList: [FollowingDTO]
}

extension ReadFollowingListResponseDTO {
    
    func toFollowing() -> [Following] {
        
        let followingList = self.followingList.map{ $0.toFollowing() }
        
        return followingList
    }
}

// 추천뷰 조회 응답 DTO
struct GetRecommendOOTDResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension GetRecommendOOTDResponseDTO {
    
    func toOOTD() -> [OOTD] {
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}


// 날씨뷰 조회 요청 DTO
struct ReadWeatherOOTDRequestDTO: Codable {
    
    let weather: String
    let tempRate: String
    let lastPage: Int
}

// 날씨뷰 OOTD 조회 응답 DTO
struct ReadWeatherOOTDListResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension ReadWeatherOOTDListResponseDTO {
    func toOOTD() -> [OOTD] {
        let ootds = self.ootdList.map { $0.toOOTD() }
        
        return ootds
    }
}

// OOTD 등록 DTO
struct AddOOTDDTO: Encodable {
    
    let region: String
    let departTime: Int
    let arrivalTime: Int
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
    let image: Data
    let wearingList: [String]
}

// 프로필 조회 구조체
struct ProfileShort: Decodable {
    
    let memberId: Int
    let nickname: String
    let imageURL: String?   // 프로필 이미지가 없으면 nil 값이 옴
    let isFollowing: Bool
    let ootdCount: Int
}

struct ProfileShortDTO: Decodable {
    
    let memberId: Int
    let nickname: String
    let imageURL: String?
    let isFollowing: Bool
    let ootdCount: Int
}

// 개별 OOTD 조회 응답 DTO
struct GetOOTDResponseDTO: Decodable {
    
    let profileShort: ProfileShortDTO
    let weather: String
    let wearing: [String]
    let isLike: Bool
}

extension GetOOTDResponseDTO {
    func toOOTDItem() -> OOTDItem {
        
        let imageURL: String = "\(Constants.serverURL)/images\(self.profileShort.imageURL ?? "")"
        
        return OOTDItem(memberId: self.profileShort.memberId, nickname: self.profileShort.nickname, imageURL: imageURL, isFollowing: self.profileShort.isFollowing, ootdCount: self.profileShort.ootdCount, weather: self.weather, wearing: self.wearing, isLike: self.isLike)
    }
}

// 타인 계정 팔로우 요청 DTO
struct FollowOtherRequestDTO: Encodable {
    let memberId: Int
}

// 타인 계정 팔로우/취소 응답 DTO
struct FollowOtherResponseDTO: Decodable {
    
    let memberId: Int
}

// OOTD 공감 요청 DTO
struct LikeOOTDRequestDTO: Encodable {
    let ootdId: Int
}

// OOTD 공감/취소 응답 DTO
struct LikeOOTDResponseDTO: Decodable {
    let ootdId: Int
}

// OOTD 등록될 날씨 미리보기 요청 DTO
// 서버에 보내는 요청 DTO
struct GetOOTDWeatherRequestDTO: Encodable {
    
    let lat: Double
    let lon: Double
    let departTime: Int
    let arrivalTime: Int
}

extension GetOOTDWeatherRequestDTO {
    
    func toOOTDWeather() -> OOTDWeather {
        
        return OOTDWeather(lat: self.lat, lon: self.lon, departTime: self.departTime, arrivalTime: self.arrivalTime)
    }
    
    static func mockData() -> GetOOTDWeatherRequestDTO {
        
        // 그냥 변환되는 EpochTime은 영국 시간 기준이고 한국 꺼는 변환된 것에서 32400을 빼야함
        
        // 가천대학교
        // 2024년 4월 30일 오전 9시 ~ 오후 6시
        return GetOOTDWeatherRequestDTO(lat: 37.4507128, lon: 127.1288495, departTime: 1714435200, arrivalTime: 1714467600)
    }
}

// OOTD 등록될 날씨 미리보기 응답 DTO
struct GetOOTDWeatherResponseDTO: Decodable {
    
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
}

// OOTD 등록 요청 DTO
struct PostOOTDRequestDTO: Encodable {
    
    let region: String
    let departTime: Int
    let arrivalTime: Int
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
    let image: Data
    let wearingList: [String]
}

// OOTD 등록 응답 DTO
struct PostOOTDResponseDTO: Decodable {
    let ootdId: Int
}

// OOTD 수정 요청 DTO
struct PutOOTDRequestDTO: Encodable {
    
    let region: String
    let departTime: Int
    let arrivalTime: Int
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
    let image: Data?
    let wearingList: [String]
}

// OOTD 수정 응답 DTO
struct PutOOTDResponseDTO: Decodable {
    
    let ootdId: Int
}

// OOTD 수정용 조회 응답 DTO
struct GetOOTDforPutResponseDTO: Decodable {
    
    let ootdId: Int
    let region: String
    let departTime: Int
    let arrivalTime: Int
    let weather: String
    let lowestTemp: Int
    let highestTemp: Int
    let imageURL: String
    let wearingList: [String]
}

extension GetOOTDforPutResponseDTO {
    
    func toGetOOTDforPut() -> GetOOTDforPut {
        
        return GetOOTDforPut(ootdId: self.ootdId, region: self.region, departTime: self.departTime, arrivalTime: self.arrivalTime, weather: Weather(rawValue: weather) ?? .SUNNY, lowestTemp: self.lowestTemp, highestTemp: self.highestTemp, imageURL: "\(Constants.serverURL)/images\(self.imageURL)", wearingList: self.wearingList)
    }
}

// OOTD 기능 제한 확인 응답 DTO
struct GetBanPeriodResponseDTO: Decodable {
    
    let banPeriod: Int
}


// 타인 프로필 및 OOTD 목록 조회 응답 DTO
struct GetOtherProfileResponseDTO: Decodable {
    
    let lastPage: Int
    let ootdList: [OOTDDTO]
}

extension GetOtherProfileResponseDTO {
    
    func toOtherProfile() -> OtherProfile {
        
        return OtherProfile(lastPage: self.lastPage, ootdList: self.ootdList.compactMap { $0.toOOTD()} )
    }
}

// OOTD 신고 요청 DTO
struct ReportOOTDRequestDTO: Encodable {
    
    let ootdId: Int
    let reason: String
}

// 팔로잉 목록 검색 응답 DTO
struct SearchFollowingListResponseDTO: Decodable {
    
    let lastPage: Int
    let followingList: [FollowingDTO]
}
