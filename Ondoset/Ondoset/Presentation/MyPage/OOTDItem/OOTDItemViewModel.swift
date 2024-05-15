//
//  OOTDItemViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/29/24.
//

import Foundation

class OOTDItemViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var ootdItem: OOTDItem?
    
    // OOTD 작성자에 대한 팔로우 상태 여부
    @Published var isFollowing: Bool = false
    
    // 개별 OOTD 조회
    func getOOTDItem(ootdId: Int) async {
        
        if let ootdItem = await ootdUseCase.getOOTD(ootdId: ootdId) {
            
            DispatchQueue.main.async {
                self.ootdItem = ootdItem
                
                self.isFollowing = ootdItem.isFollowing
            }
        }
    }
    
    // 타인 계정 팔로우
    func followOther() async {
        
        let result = await ootdUseCase.followOther(followOtherDTO: FollowOtherRequestDTO(memberId: ootdItem?.memberId ?? 0))
        
        if result {
            
            DispatchQueue.main.async {
                self.isFollowing = true
            }
        }
    }
    
    // 타인 계정 팔로우 취소
    func cancelFollowOther() async {
        
        let result = await ootdUseCase.cancelFollowOther(memberId: ootdItem?.memberId ?? 0)
        
        if result {
            
            DispatchQueue.main.async {
                self.isFollowing = false
            }
        }
    }
    
    // OOTD 공감
    func likeOOTD(ootdId: Int) async {
        
        let result = await ootdUseCase.likeOOTD(likeOOTDDTO: LikeOOTDRequestDTO(ootdId: ootdId))
        
        if result {
            DispatchQueue.main.async {
                self.ootdItem?.isLike = true
            }
        }
    }
    
    // OOTD 공감 취소
    func cancelLikeOOTD(ootdId: Int) async {
        let result = await ootdUseCase.cancelLikeOOTD(ootdId: ootdId)
        
        if result {
            DispatchQueue.main.async {
                self.ootdItem?.isLike = false
            }
        }
    }
    
    // OOTD 기능 제한 확인
    func getBanPeriod() async -> Int {
        
        if let result = await ootdUseCase.getBanPeriod() {
            
            print("금지 기간: \(result)")
            
            return result
            
        } else {
            
            return -3
        }
    }
    
    // OOTD 삭제
    func deleteOOTD(ootdId: Int) async -> Bool {
        
        if let result = await ootdUseCase.deleteOOTD(ootdId: ootdId) {
            
            return true
        } else {
            return false
        }
    }
    
    // OOTD 신고
    func reportOOTD(ootdId: Int, reason: String) async -> Bool {
        
        if let result = await ootdUseCase.reportOOTD(reportOOTDDTO: ReportOOTDRequestDTO(ootdId: ootdId, reason: reason)) {
            
            return true
        } else {
            return false
        }
    }
}
