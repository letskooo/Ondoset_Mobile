//
//  AICoordiRecommendViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/12/24.
//

import SwiftUI

final class AICoordiRecommendViewModel: ObservableObject {
    @Published var clothesData: [ClothTemplate] = ClothTemplate.mockData()
    @Published var tempIndicator: TempIndicatorType? = nil
    @Published var currentDate: Date  = .now
    @Published var isSaveAvailable: Bool = false
    
    init(clothesData: [ClothTemplate]) {
        self.clothesData = clothesData
        
        // 템플릿에서 옷 선택하기
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SelectCloth"), object: nil, queue: .main) { notification in
            if let clothes = notification.userInfo?["clothes"] as? Clothes, let index = notification.userInfo?["index"] as? Range<Array<ClothTemplate>.Index>.Element {
                print("Received notification with SelectCloth: \(clothes)")
                DispatchQueue.main.async {
                    withAnimation {
                        self.clothesData[index].searchMode = false
                        self.clothesData[index].cloth = clothes
                    }
                }
            }
        }
        
        // 템플릿 삭제하기
        NotificationCenter.default.addObserver(forName: NSNotification.Name("DeleteCloth"), object: nil, queue: .main) { notification in
            if let index = notification.userInfo?["index"] as? Range<Array<ClothTemplate>.Index>.Element {
                print("Received notification with DeleteCloth: \(index)")

                DispatchQueue.main.async {
//                    withAnimation {
                    self.clothesData.remove(at: index)
//                    }
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectCloth"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("DeleteCloth"), object: nil)
    }
}

// MARK: Interface Functions
extension AICoordiRecommendViewModel {
    func deleteClothes(with idx: Int) {
        self.clothesData.remove(at: idx)
    }
    
//    func addClothes(with )
}
