//
//  OOTDUseCase.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class OOTDUseCase {
    
    static let shared = OOTDUseCase()
    
    let ootdRepository: OOTDRepository = OOTDRepository.shared
    
    // 내 프로필 조회
    func readMyProfile() async -> MemberProfile? {
        
        if let memberProfileDTO = await ootdRepository.readMyProfile() {
            
            return memberProfileDTO.toMemberProfile()
        } else {
            return nil
        }
    }
}
