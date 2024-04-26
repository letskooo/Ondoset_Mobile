//
//  GetCoordiView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/26/24.
//

import SwiftUI

struct GetCoordiView: View {
    
    @ObservedObject var addOOTDVM: AddOOTDViewModel
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        
        VStack {
            
            navigationTopBar
            
            Spacer()
            
        }
    }
    
    private var navigationTopBar: some View {
        HStack {
            
            Button {
                
                isSheetPresented.toggle()
                
            } label: {
                Text("닫기")
                    .padding(.leading, 15)
                    .font(Font.pretendard(.regular, size: 17))
                    .foregroundStyle(.darkGray)
            }
            
            Spacer()

        }
        .padding(.top, 11)
        .overlay {
            
            Text("내 코디 기록에서 불러오기")
                .font(Font.pretendard(.semibold, size: 17))
                .foregroundStyle(.black)
                .padding(.top, 10)
        }
    }
}

#Preview {
    GetCoordiView(addOOTDVM: AddOOTDViewModel(), isSheetPresented: .constant(true))
}
