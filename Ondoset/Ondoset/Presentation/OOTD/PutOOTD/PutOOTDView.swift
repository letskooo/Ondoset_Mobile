//
//  PutOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import SwiftUI

/// OOTD 수정하기 화면

struct PutOOTDView: View {
    
    // 불러오기 sheet 활성화 여부
    @State private var isSheetPresented = false
    
    // 외출 출발 날짜
    @State var selectedDepartDate: Date = Date()
    
    // 외출 도착 시간
    @State var selectedArrivalDate: Date = Date()
    
    // OOTD 이미지
    @State var ootdImage: UIImage = UIImage()
    
    // OOTD 이미지 선택 여부
    @State var isOOTDImageSelected: Bool = false

    // 입은 옷 목록(화면용)
    @State var ootdClothes: [String] = []
    
    // 사진 보관함 활성화 여부
    @State private var openPhoto: Bool = false
    
    @State var isLocationSearchSheetPresented: Bool = false
    
    @State var locationSearchText: String = "지역 검색"
    @State var ootdLat: Double = 91.0
    @State var ootdLon: Double = 91.0
    
    
    @StateObject var addOOTDVM: AddOOTDViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .top) {
                
                if isOOTDImageSelected {
                    
                    Image(uiImage: ootdImage)
                        .resizable()
                        .aspectRatio(9/16, contentMode: .fill)
                        .frame(width: screenWidth / 2.5)
                        .onTapGesture {
                            openPhoto = true
                        }
                        .onAppear {
                            
                            print(ootdImage)
                            
                            // MARK: 나중에 화질 구리면 0.1 -> 0.7로 수정
                            if let imageData = ootdImage.jpegData(compressionQuality: 0.1) {
                                addOOTDVM.ootdImage = imageData
                            }
                            
                        }
                        .onChange(of: ootdImage) { image in
                            
                            print(image)

                            // MARK: 나중에 화질 구리면 0.1 -> 0.7로 수정
                            if let imageData = image.jpegData(compressionQuality: 0.1) {
                                addOOTDVM.ootdImage = imageData
                            }
                        }
                        
                } else {
                    
                    Image("addOOTDPhoto")
                        .resizable()
                        .aspectRatio(9/16, contentMode: .fill)
                        .frame(width: screenWidth / 2.5)
                        .onTapGesture {
                            openPhoto = true
                        }
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    Text("날짜 및 외출시간")
                        .font(Font.pretendard(.semibold, size: 17))
                    
                    VStack {
                        
                        Group {
                            Text("외출 출발 시간")
                            DatePicker("외출 출발 시간", selection: $selectedDepartDate)
                                .labelsHidden()
//                                .frame(maxWidth: screenWidth / 2)  // 최대 너비 설정
//                                .fixedSize()
                                .onAppear {
                                    
                                    var dateEpoch = dateToEpoch(selectedDate: selectedDepartDate)
                                    addOOTDVM.ootdDepartTime = dateEpoch

                                    print(selectedDepartDate)
                                    print(dateToString(selectedDate: selectedDepartDate))
                                    print(dateToEpoch(selectedDate: selectedDepartDate))
                                    
                                }
                        }
                        .padding(.top, 5)
                    }
                    .onChange(of: selectedDepartDate) { date in
                        
                        var dateEpoch = dateToEpoch(selectedDate: date)
                        addOOTDVM.ootdDepartTime = dateEpoch

                        print(date)
                        print(dateToString(selectedDate: date))
                        print(dateToEpoch(selectedDate: date))
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("외출 도착 시간")
                        DatePicker("외출 도착 시간", selection: $selectedArrivalDate).labelsHidden()
                            .frame(width: screenWidth / 4, height: 60)
                            .onAppear {
                                
                                var dateEpoch = dateToEpoch(selectedDate: selectedArrivalDate)
                                
                                addOOTDVM.ootdArrivalTime = dateEpoch
                                print(selectedArrivalDate)
                                print(dateToString(selectedDate: selectedArrivalDate))
                                print(dateToEpoch(selectedDate: selectedArrivalDate))
                            }
                        

                    }
                    .onChange(of: selectedArrivalDate) { date in
                        
                        var dateEpoch = dateToEpoch(selectedDate: date)
                        
                        addOOTDVM.ootdArrivalTime = dateEpoch
                        print(date)
                        print(dateToString(selectedDate: date))
                        print(dateToEpoch(selectedDate: date))
            
                    }
                }
                .aspectRatio(9/16, contentMode: .fit)
//                .background(.yellow)
                
            }// HStack
            .padding(.horizontal, 5)
            
            HStack {
                
                Text("입은 옷 정보")
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .font(Font.pretendard(.semibold, size: 17))
                
                Spacer()
                
                Button {
                    
                    // 나중에 지역 검색 시트 화면 올라오고 지역 확정되면 아래 메소드가 나가는 걸로 해야함
                    Task {
//                        await addOOTDVM.getOOTDWeather()
                        isLocationSearchSheetPresented = true
                    }
                    
                } label: {
                    
                    HStack {
                        Text(locationSearchText)
                            .font(Font.pretendard(.semibold, size: 15))
                            .foregroundStyle(locationSearchText == "지역 검색" ? .blue : .black)
                        
                        Image("location")
                    }
                }
                
            }
                
            Rectangle()
                .frame(width: screenWidth - 36, height: 42)
                .foregroundStyle(Color(hex: 0xEDEEFA))
                .cornerRadius(30)
                .overlay {
                    
                    HStack {
                        
                        TextField("추가할 옷 이름을 입력해주세요", text: $addOOTDVM.addClothInputText)
            
                        Button {
                            
                            ootdClothes.append(addOOTDVM.addClothInputText)
                            addOOTDVM.ootdWearingList.append(addOOTDVM.addClothInputText)
                            addOOTDVM.addClothInputText = ""
                            
                        } label: {
                            Text("추가")
                                .font(Font.pretendard(.regular, size: 15))
                                .foregroundStyle(.black)
                        }
                        
                    }
                    .padding(.horizontal, 15)
                }
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    VStack {
                        ForEach(ootdClothes.indices, id: \.self) { index in
                            
                            HStack {
                                
                                Text(ootdClothes[index])
                                    .font(Font.pretendard(.semibold, size: 13))
                                
                                Button {
                                    
                                    ootdClothes.remove(at: index)
//                                    addOOTDVM.addOOTD?.wearingList.remove(at: index)
                                    //addOOTDVM.ootdWearingList?.remove(at: index)
                                    
                                    addOOTDVM.ootdWearingList.remove(at: index)
                                    
                                    
                                } label: {
                                    Image("xBtn")
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 10)
            .frame(width: screenWidth - 36)
//            .background(.red)
            
            ButtonComponent(isBtnAvailable: $addOOTDVM.isRegisterBtnAvailable, width: screenWidth - 50, btnText: "등록하기", radius: 15) {
                
                Task {
                    
                    let result = await addOOTDVM.registerOOTD()
                    
                    if result {
                        dismiss()
                    }
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .onChange(of: addOOTDVM.ootdDepartTime) { _ in
            
            Task {
                
                await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
        }
        .onChange(of: addOOTDVM.ootdArrivalTime) { _ in
            
            Task {
                
                await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
        }
        .onChange(of: ootdLat) { _ in
            
            Task {
                
                await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
            
        }
        .padding(.horizontal, 20)
        .navigationTitle("내 OOTD 수정하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {

                Button {
                    
                    dismiss()
                    
                } label: {
                    Image("leftChevron")
                }
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    
                    isSheetPresented.toggle()
                    
                } label: {
                    Text("불러오기")
                        .font(Font.pretendard(.semibold, size: 17))
                        .foregroundStyle(.main)
                }
            }
        }
        .padding(.top, 10)
        .sheet(isPresented: $isSheetPresented) {
            GetCoordiView(ootdClothes: $ootdClothes, addOOTDVM: addOOTDVM, isSheetPresented: $isSheetPresented)
        }
        .sheet(isPresented: $isLocationSearchSheetPresented) {
            
            LocationView(locationSearchText: $locationSearchText, lat: $ootdLat, lon: $ootdLon, isLocationViewSheetPresented: $isLocationSearchSheetPresented)
        }
        .sheet(isPresented: $openPhoto, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $ootdImage)
        })
        .onChange(of: ootdImage) { image in
            isOOTDImageSelected = true
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                addOOTDVM.ootdImage = imageData
            }
        }
        .onAppear {
            wholeVM.isTabBarHidden = true
        }
        .onChange(of: isOOTDImageSelected) { _ in
            
            updateIsRegisterBtnAvailable()
        }
        .onChange(of: ootdClothes) { _ in
            updateIsRegisterBtnAvailable()
        }
    }
    
    func updateIsRegisterBtnAvailable() {
        addOOTDVM.isRegisterBtnAvailable = isOOTDImageSelected && !ootdClothes.isEmpty
    }
    
    // MARK: 나중에 32400 뺄 필요 없다고 하면 지우기
    func dateToEpoch(selectedDate: Date) -> Int {
        
        let epochTime = selectedDate.timeIntervalSince1970
        
        return Int(epochTime)
        //return (Int(epochTime) - 32400)
    }
    
    func dateToString(selectedDate: Date) -> String {
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        
        formatter.dateFormat = "yyyy년 MM월 dd일 a HH시 mm분"
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        
        return formatter.string(from: selectedDate)
    }
}

#Preview {
    PutOOTDView()
}
