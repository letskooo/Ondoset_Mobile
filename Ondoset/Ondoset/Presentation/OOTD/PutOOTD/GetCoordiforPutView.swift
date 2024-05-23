//
//  GetCoordiforPutView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import SwiftUI

//
//  GetCoordiView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/26/24.
//

import SwiftUI

struct GetCoordiforPutView: View {
    
    @State private var selectedDate = Date()
    
    @State private var isRegisterBtnAvailable: Bool = false
    
    // 이 화면에서 쓰이는 옷 리스트
    @State private var getCoordiViewClothesList: [String] = []
    
    @Binding var ootdClothes: [String]
    
    @ObservedObject var putOOTDVM: PutOOTDViewModel
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        
        VStack {
            
            navigationTopBar
            
            HStack {
                
                Image("calendar")
                
                DatePicker("날짜를 선택하세요", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .tint(.main)
                
                Spacer()
                
            }
            .padding(.leading, 20)
            
            // 이 날의 코디가 존재하지 않는다면
            if putOOTDVM.dailyCoordi == [] {
                
                VStack {
                    
                    Spacer()
                    
                    BlankDataIndicateComponent(explainText: "이 날은 등록된 코디가 없어요 \n다른 날짜를 선택하세요")
                    
                    Spacer()

                }
                
            } else {
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach(putOOTDVM.dailyCoordi.first?.clothesList ?? [], id: \.self) { cloth in
                        ClothSelectedComponent(category: cloth.category, clothName: cloth.name, clothTag: cloth.tag, clothThickness: cloth.thickness, width: screenWidth - 50)
                    }
                }
                .padding(.top, 15)
                
            }
            
            ButtonComponent(isBtnAvailable: $isRegisterBtnAvailable, width: screenWidth - 40, btnText: "이 코디에서 태그 불러오기", radius: 15) {
                
                putOOTDVM.ootdWearingList = getCoordiViewClothesList
                ootdClothes = getCoordiViewClothesList
                
                isSheetPresented = false
                
            }
            .padding(.bottom, 20)
            
            
        }
        .onChange(of: putOOTDVM.dailyCoordi) { dailyCoordi in
            
            getCoordiViewClothesList = dailyCoordi.first?.clothesList.map { $0.name } ?? []
            
            print("옷 리스트: \(getCoordiViewClothesList)")
            
            if dailyCoordi != [] {
                
                isRegisterBtnAvailable = true
            } else {
                isRegisterBtnAvailable = false
            }
        }
        .onChange(of: selectedDate) { _ in
            
            let calendar = Calendar.current
            var year = calendar.component(.year, from: selectedDate)
            var month = calendar.component(.month, from: selectedDate)
            var day = calendar.component(.day, from: selectedDate)
            
            Task {
                
                await putOOTDVM.getDailyCoordi(year: year, month: month, day: day)
                
            }
            
            print("선택된 날짜: \(selectedDate)")
            print(year)
            print(month)
            print(day)
        }
        .onAppear {
            
            if putOOTDVM.dailyCoordi != [] {
                isRegisterBtnAvailable = true
            }
            
            let calendar = Calendar.current
            var year = calendar.component(.year, from: selectedDate)
            var month = calendar.component(.month, from: selectedDate)
            var day = calendar.component(.day, from: selectedDate)
            
            Task {
                
                await putOOTDVM.getDailyCoordi(year: year, month: month, day: day)
                
            }
            
            print("선택된 날짜: \(selectedDate)")
            print(year)
            print(month)
            print(day)
            
        }
    }
    
    private var navigationTopBar: some View {
        HStack {
            
            Button {
                
                getCoordiViewClothesList = []
                
                isSheetPresented.toggle()
                
            } label: {
                Text("닫기")
                    .padding(.leading, 15)
                    .font(Font.pretendard(.regular, size: 17))
                    .foregroundStyle(.darkGray)
            }
            
            Spacer()

        }
        .padding(.top, 11)
        .overlay {
            
            Text("내 코디 기록에서 불러오기")
                .font(Font.pretendard(.semibold, size: 17))
                .foregroundStyle(.black)
                .padding(.top, 10)
        }
    }
}

#Preview {
    GetCoordiforPutView(ootdClothes: .constant([]), putOOTDVM: PutOOTDViewModel(), isSheetPresented: .constant(true))
}
