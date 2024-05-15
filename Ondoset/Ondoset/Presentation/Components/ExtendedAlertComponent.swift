//
//  ExtendedAlertComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 5/12/24.
//

import SwiftUI

struct ExtendedAlertComponent: View {
    
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Binding var showAlert: Bool
    
    let isTabBarExist: Bool
    
    let alertTitle: String
    let content: AnyView
    
    let leftBtnTitle: String? = "취소"
    
    let rightBtnTitle: String
    let rightBtnAction: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showAlert = false
                    
                    // 탭바가 존재하지 않으면
                    if !isTabBarExist {
                        wholeVM.isTabBarAlertStatus = false
                    }
                }

            VStack(spacing: 0) {
                
                Text(alertTitle)
                    .padding(.top, 16)
                    .font(Font.pretendard(.bold, size: 17))
                
                content
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                
                HStack(spacing: 16) {
                    
                    if let leftBtnTitle = leftBtnTitle {
                        
                        Button {
                            
                            showAlert = false
                            
                            // 탭바가 존재하면
                            if !isTabBarExist {
                                wholeVM.isTabBarAlertStatus = false
                            }
                            
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
                        
                        // 탭바가 존재하면
                        if !isTabBarExist {
                            wholeVM.isTabBarAlertStatus = false
                        }
                        
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
            
            if isTabBarExist {
                wholeVM.isTabBarAlertStatus = true
            }
        }
    }
}

//#Preview {
//    ExtendedAlertComponent(showAlert: .constant(true), alertTitle: "로그아웃", content: AnyView, alertContent: "삭제하면 취소할 수 없습니다. \n정말로 삭제하시겠습니까?",  rightBtnTitle: "확인", rightBtnAction: {})
//}
