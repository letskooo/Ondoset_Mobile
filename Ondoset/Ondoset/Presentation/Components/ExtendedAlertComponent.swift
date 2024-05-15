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
    
    let alertTitle: String
    
    let content: AnyView
    
    let leftBtnAction: (() -> Void)?
    
    var rightBtnTitle: String
    
    var rightBtnAction: () -> Void
    
    var isTabBarExists: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    showAlert = false
                    
                    if isTabBarExists {
                        
                        wholeVM.isTabBarAlertStatus = false
                    } else {
                        wholeVM.isTabBarAlertStatus = true
                    }
                }
            
            VStack(spacing: 0) {
                
                
                Text(alertTitle)
                    .padding(.top, 16)
                    .font(Font.pretendard(.bold, size: 17))
                
                content
                    .padding(.top, 8)
                    
                if let leftBtnAction = leftBtnAction {
                    
                    HStack(spacing: 16) {
                        
                        Button {
                            
                            showAlert = false
                            
                            wholeVM.isTabBarAlertStatus = false
                            
                            
                        } label: {
                            
                            Text("취소")
                                .font(Font.pretendard(.bold, size: 17))
                                .foregroundStyle(.darkGray)
                                .frame(width: 125, height: 50)
                        }
                        .background(.lightGray)
                        .cornerRadius(10)
                        
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
                    
                } else {
                    
                    HStack {
                        
                        Button {
                            
                            rightBtnAction()
                            wholeVM.isTabBarAlertStatus = false
                            
                        } label: {
                            Text(rightBtnTitle)
                                .font(Font.pretendard(.bold, size: 17))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .background(.main)
                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    .padding(.bottom, 16)
                    
                    
                }
                
                
                
            }
            .background(Color.white)
            .frame(width: screenWidth - 120)
            .padding(.horizontal, 30)
            .cornerRadius(12)
        }
        .onAppear {
            
            if isTabBarExists {
                
                wholeVM.isTabBarAlertStatus = false
            } else {
                wholeVM.isTabBarAlertStatus = true
            }
        }
        
    }
}

//#Preview {
//    ExtendedAlertComponent()
//}
