//
//  LikeOOTDViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import Foundation

class LikeOOTDViewModel: ObservableObject {
    
    let ootdUseCase: OOTDUseCase = OOTDUseCase.shared
    
    @Published var ootdList: [OOTD] = []
    
    var lastPage: Int = -1
    
    init() {
        
        Task {
            await readLikeOOTDList()
        }
    }
    
    // 공감한 OOTD 조회
    func readLikeOOTDList() async {
        
        if lastPage != -2 {
            
            if let result = await ootdUseCase.readLikeOOTDList(lastPage: lastPage) {
                
                DispatchQueue.main.async {
                    
                    self.ootdList.append(contentsOf: result.ootdList)
                    
                    self.lastPage = result.lastPage
                }
            }
        }
    }
}
