//
//  InitialNavPath.swift
//  Ondoset
//
//  Created by KoSungmin on 4/11/24.
//

import Foundation
import SwiftUI

enum SignUpViews {
    
    case SignUpView
    case RegisterNickNameView
}

struct SignUpNavPath {
    
    var id: SignUpViews
    var path: [SignUpNavPath]
    
    static func setInitialNavPath(id: SignUpViews, path: Binding<[SignUpViews]>) -> AnyView {
        
        switch id {
        case .SignUpView:
            return AnyView(SignUpView(path: path))
        case .RegisterNickNameView:
            return AnyView(RegisterNickNameView(path: path))
        }
    }
}
