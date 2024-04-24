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
    let thickness: String
}

struct GetAllMyClothesDTO: Decodable {
    let isEOF: Bool
    let clothesList: [ClothesDTO]
}

extension ClothesDTO {
    
    func toClothes() -> Clothes? {
        guard let category = Category(rawValue: self.category.uppercased()),
              let thickness = Thickness(rawValue: self.thickness.uppercased())
        else { return nil }
        
        return Clothes(
            clothesId: self.clothesId,
            name: self.name,
            category:  category,
            tag: self.tag,
            thickness:  thickness
        )
    }
    
    static func mockData() -> [Clothes] {
        return  [
            ClothesDTO(clothesId: 1, name: "상의1", imageURL: "image1.jpg", category: "TOP", tag: "태그1", thickness: "NORMAL"),
            ClothesDTO(clothesId: 2, name: "하의1", imageURL: "image2.jpg", category: "BOTTOM", tag: "태그2", thickness: "THIN"),
            ClothesDTO(clothesId: 3, name: "아우터1", imageURL: "image3.jpg", category: "OUTER", tag: "태그3", thickness: "THICK"),
            ClothesDTO(clothesId: 4, name: "신발1", imageURL: "image4.jpg", category: "SHOE", tag: "태그4", thickness: "NORMAL"),
            ClothesDTO(clothesId: 5, name: "악세서리1", imageURL: "image5.jpg", category: "ACC", tag: "태그5", thickness: "THIN"),
            ClothesDTO(clothesId: 6, name: "상의2", imageURL: "image1.jpg", category: "TOP", tag: "태그1", thickness: "NORMAL"),
            ClothesDTO(clothesId: 7, name: "하의2", imageURL: "image2.jpg", category: "BOTTOM", tag: "태그2", thickness: "THIN"),
            ClothesDTO(clothesId: 8, name: "아우터2", imageURL: "image3.jpg", category: "OUTER", tag: "태그3", thickness: "THICK"),
            ClothesDTO(clothesId: 9, name: "신발2", imageURL: "image4.jpg", category: "SHOE", tag: "태그4", thickness: "NORMAL"),
            ClothesDTO(clothesId: 10, name: "악세서리2", imageURL: "image5.jpg", category: "ACC", tag: "태그5", thickness: "THIN")
        ].compactMap { $0.toClothes() }
    }
}
