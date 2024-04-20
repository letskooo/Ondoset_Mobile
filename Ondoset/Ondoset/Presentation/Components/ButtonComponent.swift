//
//  ButtonComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/10/24.
//

import SwiftUI

struct ButtonComponent: View {
    
    @Binding var isBtnAvailable: Bool
    let width: CGFloat
    let btnText: String
    let radius: CGFloat
    let action: () -> Void
    
    var body: some View {
        
        Button {
            
            if self.isBtnAvailable == true {
                action()
            }
        } label: {
            
            Rectangle()
                .foregroundStyle(self.isBtnAvailable ? .main : .lightGray)
                .frame(width: width, height: 50)
                .cornerRadius(radius)
                .overlay(
                    Text("\(btnText)")
                        .font(Font.pretendard(.bold, size: 17))
                        .foregroundStyle(self.isBtnAvailable ? .white : .darkGray)
                )
        }
    }
}

#Preview {
    ButtonComponent(isBtnAvailable: .constant(true), width: 340, btnText: "다음으로", radius: 15, action: {})
}
