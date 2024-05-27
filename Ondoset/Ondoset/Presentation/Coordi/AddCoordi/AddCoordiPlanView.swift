//
//  AddCoordiPlanView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/7/24.
//

import SwiftUI

struct AddCoordiPlanView: View {
    
    // 선택된 탭
    @State var selectedTab: Int = 0
    
    // 검색창에 입력하는 텍스트
    @State var searchText: String = ""
    
    // 코디 계획하기 sheet 내리기 여부
    @Binding var isAddCoordiPlanSheetPresented: Bool
    
    let columns: [GridItem] = Array(repeating: .init(.fixed((screenWidth - 36)/3), spacing: 10), count: 3)
    
    // 길게 눌렀는지 여부
    @State var isLongPressed: Bool = false
    
    // 현재 길게 누른 옷
    @State var longPressedCloth: Clothes = Clothes(clothesId: 0, name: "", category: .ACC, tag: "", tagId: 0)
    
    @State var selectedClothes: [Int:Bool] = [:]
    
    
    @State var isSaveBtnAvailable: Bool = false
    
    // 코디를 등록하려는 날짜
    @Binding var coordiYear: Int
    @Binding var coordiMonth: Int
    @Binding var coordiDay: Int
    
    // 코디 옷 리스트
    @Binding var coordiClothesList: [Clothes]
    
    @StateObject var addCoordiRecordVM: AddCoordiRecordViewModel = .init()
    @EnvironmentObject var coordiMainVM: CoordiMainViewModel
    
    var body: some View {
        
        VStack {
            
            navigationTopBar
            
            SegmentControlComponent(selectedTab: $selectedTab, tabMenus: MyClosetTab.allCases.map{$0.rawValue}, isMain: true)
                .onChange(of: selectedTab) { _ in
                    
                    Task {
                        
                        switch selectedTab {
                            
                        case 1:
                            await addCoordiRecordVM.getAllClothesByCategory(category: .TOP, lastPage: addCoordiRecordVM.getAllClothesByTopLastPage)
                        
                        case 2:
                            await addCoordiRecordVM.getAllClothesByCategory(category: .BOTTOM, lastPage: addCoordiRecordVM.getAllClothesByBottomLastPage)
                            
                        case 3:
                            await addCoordiRecordVM.getAllClothesByCategory(category: .OUTER, lastPage: addCoordiRecordVM.getAllClothesByOuterLastPage)
                            
                        case 4:
                            await addCoordiRecordVM.getAllClothesByCategory(category: .SHOE, lastPage: addCoordiRecordVM.getAllClothesByShoeLastPage)
                        
                        case 5:
                            await addCoordiRecordVM.getAllClothesByCategory(category: .ACC, lastPage: addCoordiRecordVM.getAllClothesByAccLastPage)
               
                        default:
                            await addCoordiRecordVM.getAllClothes(lastPage: addCoordiRecordVM.getAllClothesLastPage)
                        }
                        
                    }
                    print("탭 넘버: \(selectedTab)")
                    
                }
            
            SearchBarComponent(searchText: $searchText, placeHolder: "등록한 옷을 검색하세요") { text in
                
                Task {
                    
                    switch selectedTab {
                        
                    case 1:
                        await addCoordiRecordVM.searchClothByKeyword(category: .TOP, clothesName: text)
                        
                    case 2:
                        await addCoordiRecordVM.searchClothByKeyword(category: .BOTTOM, clothesName: text)
                        
                    case 3:
                        await addCoordiRecordVM.searchClothByKeyword(category: .OUTER, clothesName: text)
                        
                    case 4:
                        await addCoordiRecordVM.searchClothByKeyword(category: .SHOE, clothesName: text)

                    case 5:
                        await addCoordiRecordVM.searchClothByKeyword(category: .ACC, clothesName: text)
                        
                    default:
                        await addCoordiRecordVM.searchClothByKeyword(category: nil, clothesName: text)
                    }
                }
            }
            .frame(width: screenWidth - 20)
            
            
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(addCoordiRecordVM.clothesList, id: \.self) { cloth in
                            
                            ZStack {
                                                                
                                ClothSearchComponent(clothes: cloth)
                                    .onTapGesture {
                                        selectedClothes[cloth.clothesId] = true
                                        
                                        coordiClothesList.append(cloth)
                                    }

                                if selectedClothes[cloth.clothesId] ?? false {
                                    
                                    Color.black.opacity(0.3)
                                        .edgesIgnoringSafeArea(.all)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            selectedClothes[cloth.clothesId] = false
                                            
                                            coordiClothesList.removeAll { $0 == cloth }

                                        }
                                    
                                    Image("clothCheck")
                                }
                                
                            }
                            .onChange(of: coordiClothesList) { _ in

                                print("옷 리스트: \(coordiClothesList.map { $0.clothesId })")
                                
                                updateBtnAvailable()
                                
                            }
                        }
                    }
                } // ScrollView
                
                if isLongPressed {
                    
                    ClothDetailComponent(clothes: longPressedCloth)
                        .frame(width: screenWidth - 90)
                }
                
            } // ZStack
            
            ButtonComponent(isBtnAvailable: $isSaveBtnAvailable, width: screenWidth - 50, btnText: "저장하기", radius: 15) {
                
                Task {
                    
                    if isDatePast(year: coordiYear, month: coordiMonth, day: coordiDay) {
                        
                        let now = Date()
                        
                        let calendar = Calendar.current
                        
                        let stateOfDay = calendar.startOfDay(for: now)
                        
                        let date = Int(stateOfDay.timeIntervalSince1970)
    
                        let result = await addCoordiRecordVM.setCoordiPlan(date: date, clothesList: coordiClothesList.map { $0.clothesId } )
                        
                        if result {
                            
                            isAddCoordiPlanSheetPresented = false
                            
                            await coordiMainVM.getCoordiRecord(year: coordiYear, month: coordiMonth)
                        }
                        
                    } else {
                        
                        let date = epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay)
                        
                        print("보내기 직전: \(date)============")
                        
                        let result = await addCoordiRecordVM.setCoordiPlan(date: date ?? 0, clothesList: coordiClothesList.map { $0.clothesId } )
                        
                        if result {
                            
                            isAddCoordiPlanSheetPresented = false
                            
                            await coordiMainVM.getCoordiRecord(year: coordiYear, month: coordiMonth)
                        }
                    }
                }
            }
            Spacer()
            
        } // VStack
        .padding(.bottom, 10)
        .onAppear {
            
            updateBtnAvailable()
            
            print("==========연도: \(coordiYear) ================")
            print("==========월: \(coordiMonth) ================")
            print("===========일: \(coordiDay) =================")
            
            print("현재 시간: \(epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay))")
            
            print("옷 리스트: \(coordiClothesList.map { $0.clothesId })")
            
            for cloth in coordiClothesList {
                
                selectedClothes[cloth.clothesId] = true
            }
            
        }
        .onDisappear {
            
            coordiClothesList = []
        }
    }
    
    func updateBtnAvailable() {
        
        if coordiClothesList != [] {
            
            isSaveBtnAvailable = true
            
        } else {
            isSaveBtnAvailable = false
        }
    }

    private var navigationTopBar: some View {
        HStack {
            
            Button {
                
                isAddCoordiPlanSheetPresented.toggle()
                
            } label: {
                Text("닫기")
                    .padding(.leading, 15)
                    .font(Font.pretendard(.regular, size: 17))
                    .foregroundStyle(.darkGray)
            }
            
            Spacer()

        }
        .padding(.top, 15)
        .overlay {
            
            Text("코디 계획하기")
                .font(Font.pretendard(.semibold, size: 17))
                .foregroundStyle(.black)
                .padding(.top, 10)
        }
    }
}

#Preview {
    AddCoordiPlanView(isAddCoordiPlanSheetPresented: .constant(true), coordiYear: .constant(2024), coordiMonth: .constant(5), coordiDay: .constant(24), coordiClothesList: .constant([]))
}
