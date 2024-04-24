//
//  BlankDataIndicateComponent.swift
//  Ondoset
//
//  Created by 박민서 on 4/25/24.
//

import SwiftUI

struct BlankDataIndicateComponent: View {
    
    let explainText: String

    var body: some View {
        VStack(spacing: 0) {
            Text(explainText)
                .font(.pretendard(.medium, size: 15))
                .foregroundStyle(.darkGray)
                .multilineTextAlignment(.center)
            Image(.sadCloudie)
                .frame(width: 128, height: 128)
        }
        .padding()
    }
}

#Preview {
    BlankDataIndicateComponent(explainText: "ASDF\nQWER")
}
