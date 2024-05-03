//
//  AlertComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/21/24.
//

import SwiftUI

struct AlertComponent: View {
    
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Binding var showAlert: Bool
    
    let alertTitle: String
    let alertContent: String
    
    let leftBtnTitle: String? = "취소"
    
    let rightBtnTitle: String
    let rightBtnAction: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showAlert = false
                    wholeVM.isTabBarAlertStatus = false
                }

            VStack(spacing: 0) {
                
                Text(alertTitle)
                    .padding(.top, 16)
                    .font(Font.pretendard(.bold, size: 17))
                
                Text(alertContent)
                    .padding(.top, 8)
                    .font(Font.pretendard(.regular, size: 15))
                
                HStack(spacing: 16) {
                    
                    if let leftBtnTitle = leftBtnTitle {
                        
                        Button {
                            
                            showAlert = false
                            wholeVM.isTabBarAlertStatus = false
                        } label: {
                            
                            Text(leftBtnTitle)
                                .font(Font.pretendard(.bold, size: 17))
                                .foregroundStyle(.darkGray)
                                .frame(width: 125, height: 50)
                        }
                        .background(.lightGray)
                        .cornerRadius(10)
                    }
                    
                    Button {
                        
                        rightBtnAction()
                        wholeVM.isTabBarAlertStatus = false
                    } label: {
                        Text(rightBtnTitle)
                            .font(Font.pretendard(.bold, size: 17))
                            .foregroundStyle(.white)
                            .frame(width: 125, height: 50)
                    }
                    .background(.main)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 25)
                .padding(.top, 20)
                .padding(.bottom, 16)
            }
            .background(Color.white)
            .frame(width: screenWidth - 120)
            .padding(.horizontal, 30)
            .cornerRadius(12)
        }
        .onAppear {
            wholeVM.isTabBarAlertStatus = true
        }
    }
}

#Preview {
    AlertComponent(showAlert: .constant(true), alertTitle: "로그아웃", alertContent: "삭제하면 취소할 수 없습니다. \n정말로 삭제하시겠습니까?",  rightBtnTitle: "확인", rightBtnAction: {})
}
