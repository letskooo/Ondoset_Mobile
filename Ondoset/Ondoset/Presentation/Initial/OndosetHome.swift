//
//  OndosetHome.swift
//  Ondoset
//
//  Created by KoSungmin on 4/10/24.
//

import SwiftUI

enum Tab {
    
    case home
    case record
    case closet
    case ootd
    case myPage
}

struct OndosetHome: View {
    
    @State var selectedTab: Tab = .home
    @EnvironmentObject var wholeVM: WholeViewModel
    
    var body: some View {
        
        ZStack() {
            
            switch selectedTab {
            case .home:
                HomeMainView()
            case .record:
                RecordMainView()
            case .closet:
                ClosetMainView()
            case .ootd:
                OOTDMainView()
            case .myPage:
                MyPageMainView()
            }
            
            VStack {
                Spacer()
                
                TabView(selectedTab: $selectedTab)
                    .hidden(wholeVM.isTabBarHidden)
                    .overlay {
                        if wholeVM.isTabBarAlertStatus {
                            Color.black.opacity(0.5)
                        } else {
                            Color.clear
                        }
                    }
            }
        }
    }
}

struct TabView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Image(selectedTab == .home ? "tabBarHomeSelected" : "tabBarHomeUnselected")
                .onTapGesture {
                    selectedTab = .home
                }
            
            Spacer()
            
            Image(selectedTab == .record ? "tabBarRecordSelected" : "tabBarRecordUnselected")
                .onTapGesture {
                    selectedTab = .record
                }
            
            Spacer()
            
            Image(selectedTab == .closet ? "tabBarClosetSelected" : "tabBarClosetUnselected")
                .onTapGesture {
                    selectedTab = .closet
                }
            
            Spacer()
            
            Image(selectedTab == .ootd ? "tabBarOOTDSelected" : "tabBarOOTDUnselected")
                .onTapGesture {
                    selectedTab = .ootd
                }
            
            Spacer()
            
            Image(selectedTab == .myPage ? "tabBarMyPageSelected" : "tabBarMyPageUnselected")
                .onTapGesture {
                    selectedTab = .myPage
                }
            
            Spacer()
            
        }
        .frame(width: screenWidth, height: 80)
        .background(Color(hex: 0xF8F8F8))
    }
}

#Preview {
    OndosetHome()
}
