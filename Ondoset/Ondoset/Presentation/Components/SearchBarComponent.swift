//
//  SearchBarComponent.swift
//  Ondoset
//
//  Created by 박민서 on 4/24/24.
//


import SwiftUI

struct SearchBarComponent: View {
    
    @Binding var searchText: String
    let placeHolder: String
    var searchAction: (String) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 21)
                .foregroundStyle(.ondosetBackground)
                .frame(height: 42)
            
            HStack {
                TextField(self.placeHolder, text: $searchText)
                    .font(.pretendard(.semibold, size: 15))
                    .padding(.leading, 10)
                
                Button(action: {
                    searchAction(searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(8)
                }
                .clipShape(Circle())
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    SearchBarComponent(searchText: .constant(""), placeHolder: "등록한 옷을 검색하세요", searchAction: { print($0) })
}
