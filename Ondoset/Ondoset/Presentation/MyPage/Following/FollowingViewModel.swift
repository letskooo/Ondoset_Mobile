//
//  FollowingViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import Foundation

class FollowingViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var followingList: [Following] = []
    
    var lastPage: Int = -1
    
    init() {
        Task {
            await readFollowingList()
        }
    }
    
    // 팔로잉 목록 조회
    func readFollowingList() async {
        
        if lastPage != -2 {
            
            if let result = await ootdUseCase.readFollowingList(lastPage: lastPage) {
                
                DispatchQueue.main.async {
                    
                    self.followingList.append(contentsOf: result.followingList)
                    
                    self.lastPage = result.lastPage
                }
            }
        }
    }
}
