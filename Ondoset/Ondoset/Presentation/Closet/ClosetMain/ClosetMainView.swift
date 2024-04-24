//
//  ClosetMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct ClosetMainView: View {
    var body: some View {
        
        // MARK: States
        @State var selectedTab: Int = 1
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        // MARK: Main View
        NavigationStack {
            VStack {
                SegmentControlComponent(selectedTab: $selectedTab, tabMenus: MyClosetTab.allCases.map{$0.rawValue})
            }
        }

    }
}

#Preview {
    ClosetMainView()
}
