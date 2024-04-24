//
//  MyPageMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class MyPageMainViewModel: ObservableObject {
    
    
    func logout() {
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(false, forKey: "isLogin")
        }
    }
}
