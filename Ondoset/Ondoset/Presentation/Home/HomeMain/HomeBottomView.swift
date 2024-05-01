//
//  HomeBottomView.swift
//  Ondoset
//
//  Created by 박민서 on 5/2/24.
//

import SwiftUI

struct HomeBottomView: View {
    var body: some View {
        Text("HomeBottom")
    }
}

struct HomeBottomHeaderView: View {
    // properties
    var isOOTD: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘은 이렇게 입기로 했어요!")
                    .font(.pretendard(.semibold, size: 17))
                Spacer()
                if isOOTD {
                    Button(action: {}, label: {
                        HStack(spacing: 0) {
                            Text("OOTD")
                                .font(.pretendard(.semibold, size: 13))
                            Image(systemName: "chevron.forward")
                        }
                        .foregroundStyle(.main)
                    })
                }
            }
            Divider()
                .frame(height: 2)
                .overlay(Color.white)
        }
        .padding()
    }
}

#Preview {
    HomeBottomHeaderView()
}
