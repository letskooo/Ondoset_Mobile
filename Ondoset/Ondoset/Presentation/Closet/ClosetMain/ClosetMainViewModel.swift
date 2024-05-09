//
//  ClosetMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class ClosetMainViewModel: ObservableObject {
    
    @Published var selectedTab: Int = 0
    @Published var searchText: String = ""
    @Published var clothesData: [Clothes] = []
    
}
