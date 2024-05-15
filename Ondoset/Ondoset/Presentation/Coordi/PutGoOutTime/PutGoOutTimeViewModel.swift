//
//  PutGoOutTimeViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/11/24.
//

import Foundation

class PutGoOutTimeViewModel: ObservableObject {
    
    let coordiUseCase: CoordiUseCase = CoordiUseCase.shared
    
    
    // 외출시간 등록/수정
    func setCoordiTime(coordiId: Int, lat: Double, lon: Double, region: String, departTime: Int, arrivalTime: Int) async -> Bool {
        
        if let result = await coordiUseCase.setCoordiTime(coordiId: coordiId, setCoordiTimeDTO: SetCoordiTimeRequestDTO(lat: lat, lon: lon, region: region, departTime: departTime, arrivalTime: arrivalTime)) {
            
            return true
            
        } else {
            
            return false
        }
    }
    
    
}
