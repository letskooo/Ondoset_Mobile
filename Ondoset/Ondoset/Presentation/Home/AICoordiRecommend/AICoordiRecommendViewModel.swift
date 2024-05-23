//
//  AICoordiRecommendViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/12/24.
//

import SwiftUI

final class AICoordiRecommendViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    private let coordiUseCase: CoordiUseCase = CoordiUseCase.shared
    
    @Published var clothesData: [ClothTemplate] = ClothTemplate.mockData() {
        didSet {
            Task {
                await self.fetchSatisfactionPrediction()
            }
        }
    }
    @Published var tempIndicator: TempIndicatorType? = nil
    @Published var currentDate: Date  = .now
    @Published var isSaveAvailable: Bool = false
    
    init(clothesData: [ClothTemplate]) {
        self.clothesData = clothesData
        
        Task {
            await self.fetchSatisfactionPrediction()
        }
        
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
        
        // 커스텀 템플릿에서 옷 추가하기
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AddCloth"), object: nil, queue: .main) { notification in
            if let clothes = notification.userInfo?["clothes"] as? Clothes {
                print("Received notification with SelectCloth: \(clothes)")
                DispatchQueue.main.async {
                    withAnimation {
                        self.clothesData.insert(
                            .init(
                                category: clothes.category,
                                name: clothes.name,
                                searchMode: false,
                                cloth: clothes
                            ),
                            at: 0
                        )
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
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("AppCloth"), object: nil)
    }
}

// MARK: Interface Functions
extension AICoordiRecommendViewModel {
    
    func deleteClothes(with idx: Int) {
        self.clothesData.remove(at: idx)
    }
    
    func postClothesCombination(addType: String) async {
        let _ = await coordiUseCase.setCoordiPlan(
            addType: addType,
            setCoordiPlanDTO: .init(date: self.currentDate.dateWithoutTime()!.toInt(),
                                    clothesList: self.clothesData.compactMap { $0.cloth }.map { $0.clothesId })
        )
    }
}

// MARK: Private Functions
extension AICoordiRecommendViewModel {
    private func fetchSatisfactionPrediction() async {
        let tagCombination = self.clothesData
            .compactMap { $0.cloth }
            .map { TagCombination.init(tagId: $0.tagId, thickness: $0.thickness?.rawValue)}
    
        let result = await coordiUseCase.getSatisfactionPred(getSatisfactionPredDTO: .init(tagComb: tagCombination))
        DispatchQueue.main.async {
            switch result {
            case .GOOD:
                self.tempIndicator = .good
            case .COLD, .VERY_COLD:
                self.tempIndicator = .cold
            case .HOT, .VERY_HOT:
                self.tempIndicator = .hot
            default:
                return
            }
            self.isSaveAvailable = true
        }
    }
}
