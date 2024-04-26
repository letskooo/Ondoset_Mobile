//
//  AddOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/26/24.
//

import SwiftUI

struct AddOOTDView: View {
    
    @State private var isSheetPresented = false
    
    @StateObject var addOOTDVM: AddOOTDViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                
                Image("addOOTDPhoto")
                
                VStack {
                    
                    Text("날짜 및 외출시간")
                        .font(Font.pretendard(.semibold, size: 17))
                
                    
                    VStack {
                        
                        Text("나간 시간")
                            .font(Font.pretendard(.semibold, size: 15))
                            .foregroundStyle(.darkGray)
                        
                    }
                    
                    VStack {
                        
                        Text("들어온 시간")
                            .font(Font.pretendard(.semibold, size: 15))
                            .foregroundStyle(.darkGray)
                        
                    }
                }
            }
            
            Spacer()
            
            
        }
        .navigationTitle("내 OOTD 추가하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {

                Button {
                    
                    dismiss()
                    
                } label: {
                    Image("leftChevron")
                }
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    
                    isSheetPresented.toggle()
                    
                } label: {
                    Text("불러오기")
                        .font(Font.pretendard(.semibold, size: 17))
                        .foregroundStyle(.main)
                }
                
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            GetCoordiView(addOOTDVM: addOOTDVM, isSheetPresented: $isSheetPresented)
        }
    }
}

#Preview {
    AddOOTDView()
}
