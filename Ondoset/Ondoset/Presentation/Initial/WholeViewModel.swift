//
//  OndosetHomeViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/10/24.
//

import Foundation

class WholeViewModel: ObservableObject {
    
    // 하단 탭바 숨기기 여부
    // false면 숨기지 않음. true면 숨김.
    @Published var isTabBarHidden: Bool = false
    
}
