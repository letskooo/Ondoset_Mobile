//
//  ButtonComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/10/24.
//

import SwiftUI

enum BtnStatus {
    
    case on
    case off
}

struct ButtonComponent: View {
    
    @Binding var btnStatus: BtnStatus
    let width: CGFloat
    let btnText: String
    let radius: CGFloat
    let action: () -> Void
    
    var body: some View {
        
        Button {
            
            if self.btnStatus == .on {
                action()
            }
        } label: {
            
            Rectangle()
                .foregroundStyle(self.btnStatus == .on ? .main : .lightGray)
                .frame(width: width, height: 50)
                .cornerRadius(radius)
                .overlay(
                    Text("\(btnText)")
                        .font(Font.pretendard(.bold, size: 17))
                        .foregroundStyle(self.btnStatus == .on ? .white : .darkGray)
                )
        }
    }
}

#Preview {
    ButtonComponent(btnStatus: .constant(.on), width: 340, btnText: "다음으로", radius: 15, action: {})
}
