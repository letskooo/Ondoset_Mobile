//
//  ClosetMainViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

final class ClosetMainViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    /// MyClothingView 표시
    @Published var presentMyClothing: Bool = false
    /// 삭제 alert 표시
    @Published var presentAlert: Bool = false
    /// 선택한 옷
    @Published var myClothing: Clothes? = nil
    /// 선택된 탭 넘버
    @Published var selectedTab: Int = 0 {
        // 값이 변경됨에 따라 해당 함수가 호출됩니다.
        didSet {
            self.clothesLastPage = -1 // 탭 변경 시엔 항상 -1로 시작
            Task {
                selectedTab != 0
                ? await getMyClothes(by: Category.allCases[selectedTab - 1])
                : await getMyAllClothes()
            }
        }
    }
    /// 검색 텍스트
    @Published var searchText: String = "" {
        didSet { searchClothes(by: self.searchText) }
    }
    /// 화면에 표시되는 Data
    @Published var presentingClothesData: [Clothes] = []
    /// 뒤(뷰모델)에서 관리되는 Data
    private var clothesData: [Clothes] = [] {
        didSet { setPresentingData() }
    }
    /// 삭제할 옷 데이터
    @Published var clothesIdWillDeleted: Int = -1
    /// clothes Data last page
    private var clothesLastPage: Int = -1
    
    init() {
        Task { await getMyAllClothes() }
        
        // 옷 수정하기
        NotificationCenter.default.addObserver(forName: NSNotification.Name("EditClothes"), object: nil, queue: .main) { notification in
            if let clothesId = notification.userInfo?["clothesId"] as? Int {
                print("Received notification with EDIT: \(clothesId)")
                let editClothes = self.presentingClothesData.first(where: { $0.clothesId == clothesId })
                self.myClothing = editClothes
                self.presentMyClothing = true
            }
        }
        // 옷 삭제 경고 표시하기
        NotificationCenter.default.addObserver(forName: NSNotification.Name("PresentDeleteAlert"), object: nil, queue: .main) { notification in
            if let clothesId = notification.userInfo?["clothesId"] as? Int {
                print("Received notification with DELETE_ALERT: \(clothesId)")
                self.presentAlert = true
                self.clothesIdWillDeleted = clothesId
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("EditClothes"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("PresentDeleteAlert"), object: nil)
    }
}

// MARK: Interface Functions
extension ClosetMainViewModel {
    
    func getClothesName(by clothesId: Int) -> String {
        return self.clothesData.first(where: { $0.clothesId == clothesId })?.name ?? ""
    }
    
    func deleteClothes(by clothesId: Int) {
        Task {
            await self.deleteMyClothes(with: clothesId)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                clothesLastPage = -1 // 탭 변경 시엔 항상 -1로 시작
                Task {
                    self.selectedTab != 0
                    ? await self.getMyClothes(by: Category.allCases[self.selectedTab - 1])
                    : await self.getMyAllClothes()
                }
            }
        }
    }
}

// MARK: Internal Functions
extension ClosetMainViewModel {
    
    /// 전체 clothes를 가져옵니다 by API
    private func getMyAllClothes() async {
         guard clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothes(lastPage: clothesLastPage) {
             setReceivedData(clothesList: result.clothesList, lastPage: result.lastPage)
         }
//        setReceivedData(clothesList: ClothesDTO.mockData(), lastPage: -1) // 테스트용
     }
     
    /// 카테고리 값으로 clothes를 가져옵니다 by API
    private func getMyClothes(by category: Category) async {
         guard selectedTab != 0, clothesLastPage != -2 else { return }
         
         if let result = await clothesUseCase.getAllClothesByCategory(getAllClothesByCategoryDTO: .init(category: category.rawValue, lastPage: clothesLastPage)) {
             setReceivedData(clothesList: result.clothesList, lastPage: result.lastPage)
         }
     }
    
    private func deleteMyClothes(with id: Int) async {
        if let result = await clothesUseCase.deleteCloth(clothesId: id) {
            print("삭제 완료")
            self.presentAlert = false
        }
    }
    
    /// API에서 받은 Data를 clothesData에 전달합니다.
    private func setReceivedData(clothesList: [Clothes], lastPage: Int) {
        self.clothesLastPage = lastPage
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clothesData = clothesList
        }
    }
    
    /// 새로 받은 clothesData를 화면에 표시합니다
    private func setPresentingData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchText = "" // 새로운 화면이므로 텍스트 필드가 공백
            self.presentingClothesData = self.clothesData
        }
    }
    
    /// 검색 값에 따른 Clothes 표시 데이터를 전달합니다.
    private func searchClothes(by text: String) {
        guard !text.isEmpty else {
            // 텍스트 비면 전체 데이터 표시
            self.presentingClothesData = self.clothesData
            return
        }
        self.presentingClothesData = self.clothesData.filter({ $0.name.contains(text) })
    }
}
