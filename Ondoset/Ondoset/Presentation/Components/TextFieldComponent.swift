//
//  TextFieldView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/10/24.
//

import SwiftUI

struct TextFieldComponent: View {
    
    let width: CGFloat
    let placeholder: String
    var font: Font = .pretendard(.semibold, size: 15)
    @Binding var inputText: String
    
    var body: some View {
        
        ZStack {
            
            TextField(placeholder, text: $inputText)
                .frame(width: width-36, height: 48)
                .font(font)
                .padding(.horizontal, 18)
                .background(.white)
                .cornerRadius(12)
                .shadow(color: Color(hex: 0xEDEEFA), radius: 4)
            
            Rectangle()
                .fill(.darkGray)
                .frame(width: width-36, height: 1)
                .offset(y: 15)
        }
    }
}

#Preview {
    TextFieldComponent(width: 340, placeholder: "아이디", inputText: .constant(""))
}
