//
//  Constants.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//


/// 공통적으로 쓰이는 상수를 정의해놓은 파일입니다.

import UIKit


struct Constants {
    
    static let successResponseCode: String = "common_2000"
    
}

let baseURLLL = "http://localhost:8080"
let testServerURL = "http://ceprj.gachon.ac.kr:60019"

let successResponseCode: String = "Common_2000"

let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
let screenWidth = windowScene?.screen.bounds.width ?? 0
let screenHeight = windowScene?.screen.bounds.height ?? 0
