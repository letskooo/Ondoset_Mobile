//
//  OndosetApp.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

@main
struct OndosetApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(WholeViewModel())
//            OndosetHome()
            
//            SignInView()
//                .environmentObject(WholeViewModel())
            
            // 여기서 보고 싶은 초기 화면 설정
        }
    }
}
