//
//  ViewHiddenModifier.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//


/// 뷰를 숨길 수 있는 .hidden() 모디파이어의 extension 정의 파일입니다.

import SwiftUI

extension View {
    
    func hidden(_ shouldHide: Bool) -> some View {
        modifier(ViewHiddenModifier(isHidden: shouldHide))
    }
}

struct ViewHiddenModifier: ViewModifier {
    
    var isHidden: Bool
    
    func body(content: Content) -> some View {
        
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
