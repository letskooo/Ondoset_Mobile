//
//  Coordi.swift
//  Ondoset
//
//  Created by KoSungmin on 4/8/24.
//

import Foundation

struct CoordiRecord: Hashable {
        
    let coordiId: Int
    let year: Int
    let month: Int
    let day: Int
    let satisfaction: Satisfaction?
    let region: String?
    let departTime: Int?
    let arrivalTime: Int?
    let weather: Weather?
    let lowestTemp: Int?
    let highestTemp: Int?
    let imageURL: String?
    let clothesList: [Clothes]
}
