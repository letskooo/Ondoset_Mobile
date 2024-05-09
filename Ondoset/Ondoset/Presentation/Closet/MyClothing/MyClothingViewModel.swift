//
//  MyClothingViewModel.swift
//  Ondoset
//
//  Created by 박민서 on 5/9/24.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

final class MyClothingViewModel: ObservableObject {
    
    private let clothesUseCase: ClothesUseCase = ClothesUseCase.shared
    
    @Published var myClothing: Clothes? = nil
    @Published var myClothigName: String = ""
    @Published var myClothingCategory: Category? = nil
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
    @Published var detailedTagList: [(Int, String)] = []
    @Published var myClothingDetailedTag: (Int, String) = (-1, "")
    @Published var myClothingThickness: Thickness? = nil
    @Published var saveAvailable: Bool = true
    
    init(myClothing: Clothes?) {
        if let myClothing = myClothing {
            self.myClothing = myClothing
            self.myClothigName = myClothing.name
            self.myClothingCategory = myClothing.category
//            self.myClothingImageData = myClothing. // TODO: 이미지 URL에서 data 페칭 필요
            self.myClothingDetailedTag = (myClothing.tagId, myClothing.tag)
            self.myClothingThickness = myClothing.thickness
            // TODO: 정해진 카테고리와 태그대로 API 호출 필요
        }
    }
    
}

// MARK: Interface Functions
extension MyClothingViewModel {
    func saveMyClothing() async {
        // 수정 케이스
        if let myClothing = self.myClothing {
            print("수정 : 내 옷 \(PatchClothRequestDTO(clothesId: myClothing.clothesId, name: myClothigName, tagId: myClothingDetailedTag.0, thickness: myClothingThickness?.rawValue))")
            let res = await clothesUseCase.patchCloth(
                patchClothDTO: .init(
                    clothesId: myClothing.clothesId,
                    name: myClothigName,
                    tagId: myClothingDetailedTag.0,
                    thickness: myClothingThickness?.rawValue
                )
            )
            if let res = res, res == true { print("수정완료") }
        } 
        // 저장 케이스
        else {
            print("저장 : 내 옷 \(PostClothRequestDTO(name: myClothigName,tagId: myClothingDetailedTag.0,thickness: myClothingThickness?.rawValue,image: myClothingImageData))")
            let res = await clothesUseCase.postCloth(postClothDTO: .init(
                name: myClothigName,
                tagId: myClothingDetailedTag.0,
                thickness: myClothingThickness?.rawValue,
                image: myClothingImageData)
            )
            if let res = res, res == true { print("저장완료") }
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
}
