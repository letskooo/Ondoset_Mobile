//
//  AddCoordiPlanView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/7/24.
//

import SwiftUI

struct AddCoordiPlanView: View {
    
    @Binding var isAddCoordiPlanSheetPresented: Bool
    
    var body: some View {
        
        navigationTopBar
        
        Spacer()
    }
    
    private var navigationTopBar: some View {
        HStack {
            
            Button {
                
                isAddCoordiPlanSheetPresented.toggle()
                
            } label: {
                Text("닫기")
                    .padding(.leading, 15)
                    .font(Font.pretendard(.regular, size: 17))
                    .foregroundStyle(.darkGray)
            }
            
            Spacer()

        }
        .padding(.top, 15)
        .overlay {
            
            Text("코디 계획하기")
                .font(Font.pretendard(.semibold, size: 17))
                .foregroundStyle(.black)
                .padding(.top, 10)
        }
    }
}

#Preview {
    AddCoordiPlanView(isAddCoordiPlanSheetPresented: .constant(true))
}
