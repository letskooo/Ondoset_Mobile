//
//  SecureField.swift
//  Ondoset
//
//  Created by KoSungmin on 4/12/24.
//

import SwiftUI

struct SecureFieldComponent: View {
    
    let width: CGFloat
    let placeholder: String
    @Binding var inputText: String
    
    var body: some View {
        ZStack {
            
            SecureField(placeholder, text: $inputText)
                .frame(width: width-36, height: 48)
                .font(Font.pretendard(.semibold, size: 15))
                .padding(.horizontal, 18)
                .background(.white)
                .cornerRadius(12)
                .shadow(color: Color(hex: 0xEDEEFA), radius: 4)
                .textContentType(.newPassword)
            
            Rectangle()
                .fill(.darkGray)
                .frame(width: width-36, height: 1)
                .offset(y: 15)
        }
    }
}

#Preview {
    SecureFieldComponent(width: 340, placeholder: "비밀번호", inputText: .constant(""))
}
