//
//  MyClothingViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/9/24.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import Kingfisher

final class MyClothingViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var myClothing: Clothes? = nil {
        didSet {
            guard let myClothing = self.myClothing else { return }
            print("@TAG- \(myClothing)")
            
            guard let imageURL = self.myClothing?.imageURL, let url = URL(string: "\(Constants.serverURL)/images\(imageURL)") else { return }
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                    
                case .success(let success):
                    print("@TAGIMAGE- \(success.image.pngData())")
                    DispatchQueue.main.async {
                        self.myClothingImageData = success.image.pngData()
                    }
                case .failure(let error):
                    print("Error loading image data: \(error)")
                    return
                }
            }
        }
    }
    @Published var myClothigName: String = "" {
        didSet {
            setSaveAvailable()
        }
    }
    @Published var myClothingCategory: Category? = nil {
        didSet { self.updateTagList() }
    }
    @Published var myClothingImage: PhotosPickerItem? = nil {
        didSet {
            Task {
                if let data = try? await myClothingImage?.loadTransferable(type: Data.self) {
                    self.setImageData(with: data)
                }
            }
        }
    }
    @Published var myClothingImageData: Data? = nil
    @Published var detailedTagList: [Tag] = []
    @Published var myClothingDetailedTag: Tag = Tag(tag: "", tagId: -1) {
        didSet {
            setSaveAvailable()
        }
    }
    @Published var myClothingThickness: Thickness? = nil {
        didSet {
            setSaveAvailable()
        }
    }
    @Published var saveAvailable: Bool = true
    
    private var tagList: AllTags?
    
    init(myClothing: Clothes?) {
        if let myClothing = myClothing {
            self.myClothing = myClothing
            self.myClothigName = myClothing.name
            self.myClothingCategory = myClothing.category
//            self.myClothingImageData = myClothing. // TODO: 이미지 URL에서 data 페칭 필요
            self.myClothingDetailedTag = Tag(tag: myClothing.tag, tagId: myClothing.tagId)
            self.myClothingThickness = myClothing.thickness
            // TODO: 정해진 카테고리와 태그대로 API 호출 필요
        }
        Task { await self.getTagList() } // 태그 가져오기
        setSaveAvailable()
    }
    
}

// MARK: Interface Functions
extension MyClothingViewModel {
    func saveMyClothing() async {
        // 수정 케이스
        if let myClothing = self.myClothing {
            print("수정 : 내 옷 \(PatchClothRequestDTO(clothesId: myClothing.clothesId, name: myClothigName, tagId: myClothingDetailedTag.tagId, thickness: myClothingThickness?.rawValue))")
            let res = await clothesUseCase.patchCloth(
                patchClothDTO: .init(
                    clothesId: myClothing.clothesId,
                    name: myClothigName,
                    tagId: myClothingDetailedTag.tagId,
                    thickness: myClothingThickness?.rawValue
                )
            )
            if let res = res, res == true {
                print("수정완료")
                NotificationCenter.default.post(name: NSNotification.Name("RefreshPresentClothes"), object: nil, userInfo: nil)
            }
        }
        // 저장 케이스
        else {
            print("저장 : 내 옷 \(PostClothRequestDTO(name: myClothigName,tagId: myClothingDetailedTag.tagId,thickness: myClothingThickness?.rawValue,image: myClothingImageData))")
            let res = await clothesUseCase.postCloth(postClothDTO: .init(
                name: myClothigName,
                tagId: myClothingDetailedTag.tagId,
                thickness: myClothingThickness?.rawValue,
                image: myClothingImageData)
            )
            if let res = res, res == true {
                print("저장완료")
                NotificationCenter.default.post(name: NSNotification.Name("RefreshPresentClothes"), object: nil, userInfo: nil)
            }
        }
    }
}

// MARK: Internal Functions
extension MyClothingViewModel {
    /// 선택한 이미지 데이터를 세팅합니다
    private func setImageData(with data: Data) {
        DispatchQueue.main.async {
            self.myClothingImageData = data
        }
    }
    
    /// 선택한 카테고리에 해당하는 태그 리스트로 업데이트합니다
    private func updateTagList() {
        DispatchQueue.main.async {
            switch self.myClothingCategory {
                
            case .TOP:
                self.detailedTagList = self.tagList?.top ?? []
            case .BOTTOM:
                self.detailedTagList = self.tagList?.bottom ?? []
            case .OUTER:
                self.detailedTagList = self.tagList?.outer ?? []
            case .SHOE:
                self.detailedTagList = self.tagList?.shoe ?? []
            case .ACC:
                self.detailedTagList = self.tagList?.acc ?? []
            case .none:
                self.detailedTagList = []
            }
        }
    }
    
    /// 세부 태그를 전부 가져옵니다 from API
    private func getTagList() async {
        if let result = await clothesUseCase.getTagList() {
            self.tagList = result
        }
    }
    
    private func setSaveAvailable() {
        if (myClothingDetailedTag.tagId != -1) && (myClothingThickness != nil) && (myClothigName != "") {
            self.saveAvailable = true
        } else {
            self.saveAvailable = false
        }
    }
}
