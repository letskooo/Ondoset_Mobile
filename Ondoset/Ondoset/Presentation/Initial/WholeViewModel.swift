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
    @Published var isTabBarAlertStatus: Bool = false
    // 선택된 탭
    @Published var selectedTab: Tab = .home
    
    // 카드뷰를 통해 2번 탭 접근 여부
    @Published var goToCoordiThroughHome: Bool = false
    
    /// 홈 화면 지난 번엔 이렇게 입었어요 카드뷰에서 쓰이는 저장 프로퍼티
    @Published var selectedCoordiYear: Int = 0
    @Published var selectedCoordiMonth: Int = 0
    @Published var selectedCoordiDay: Int = 0
}
