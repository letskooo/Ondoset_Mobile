//
//  RecordMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct RecordMainView: View {
    var body: some View {
        
        /// 각 탭의 메인 뷰마다 NavigationStack을 두는 것으로 설계합니다.
        
        NavigationStack {
            Text("Record")
        }
    }
}

#Preview {
    RecordMainView()
}
