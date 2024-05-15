//
//  OtherProfileViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import Foundation

class OtherProfileViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var ootdList: [OOTD] = []
    
    // 타인 계정에 대한 사용자의 팔로우 상태 여부
    @Published var isFollowing: Bool = false
    
    var lastPage: Int = -1
    
    // 타인 프로필 조회
    func getOtherProfile(memberId: Int) async {
        
        if lastPage != 2 {
            
            if let result = await ootdUseCase.getOtherProfile(memberId: memberId, lastPage: lastPage) {
                
                DispatchQueue.main.async {
                    
                    self.ootdList.append(contentsOf: result.ootdList)
                    
                    self.lastPage = result.lastPage
                }
            }
        }
    }
    
    // 타인 계정 팔로우
    func followOther(memberId: Int) async {
        
        let result = await ootdUseCase.followOther(followOtherDTO: FollowOtherRequestDTO(memberId: memberId))
        
        if result {
            
            DispatchQueue.main.async {
                self.isFollowing = true
            }
        }
    }
    
    // 타인 계정 팔로우 취소
    func cancelFollowOther(memberId: Int) async {
        
        let result = await ootdUseCase.cancelFollowOther(memberId: memberId)
        
        if result {
            
            DispatchQueue.main.async {
                self.isFollowing = false
            }
        }
    }
}
