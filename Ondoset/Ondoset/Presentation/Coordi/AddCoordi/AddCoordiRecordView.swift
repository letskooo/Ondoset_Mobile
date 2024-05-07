//
//  AddCoordiView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/7/24.
//

import SwiftUI

struct AddCoordiRecordView: View {
    
    @StateObject var addCoordiRecordVM: AddCoordiRecordViewModel = .init()
    @Binding var isAddCoordiRecordSheetPresented: Bool
    
    var body: some View {
        
        VStack {
            navigationTopBar
            
            Spacer()
        }
        .onAppear {
            Task {
                await
                addCoordiRecordVM.getAllClothesByCategory(category: .TOP,lastPage: -1)
            }
        }
        
        
    }
    
    private var navigationTopBar: some View {
        HStack {
            
            Button {
                
                isAddCoordiRecordSheetPresented.toggle()
                
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
            
            Text("나의 코디 추가하기")
                .font(Font.pretendard(.semibold, size: 17))
                .foregroundStyle(.black)
                .padding(.top, 10)
        }
    }
}

#Preview {
    AddCoordiRecordView(isAddCoordiRecordSheetPresented: .constant(true))
}
