//
//  Clothes.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

struct Clothes {
    var clothesId: Int
    var name: String
    var imageURL: String?
    var category: Category
    var tag: String
    var thickness: Thickness
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
