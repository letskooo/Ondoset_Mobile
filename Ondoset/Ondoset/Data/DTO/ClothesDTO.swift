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
