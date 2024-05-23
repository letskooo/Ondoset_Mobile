//
//  AddOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/26/24.
//

import SwiftUI

struct AddOOTDView: View {
    
    // 불러오기 sheet 활성화 여부
    @State private var isSheetPresented = false
    
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
    
    
    // 연도 피커
    @State var pickerYear: Int = 0
    // 월 피커
    @State var pickerMonth: Int = 0
    // 일 피커
    @State var pickerDay: Int = 0
    
    // 출발 시간 피커
    @State var pickerDepartTime: Int = -1
    // 도착 시간 피커
    @State var pickerArrivalTime: Int = -1
    
    // 연도 피커 보이기 여부
    @State var showPickerYear: Bool = false
    // 월 피커 보이기 여부
    @State var showPickerMonth: Bool = false
    // 일 피커 보이기 여부
    @State var showPickerDay: Bool = false
    // 출발 시간 피커 보이기 여부
    @State var showPickerDepartTime: Bool = false
    // 도착 시간 피커 보이기 여부
    @State var showPickerArrivalTime: Bool = false
    
    
    @StateObject var addOOTDVM: AddOOTDViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .top, spacing: 5) {
                
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
//                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Spacer()
                    
                    Text("날짜 및 외출시간")
                        .font(Font.pretendard(.semibold, size: 17))
                    
//                    Spacer()
                    
                    Text("터치하여 선택해주세요")
                        .frame(width: 150)
                        .font(Font.pretendard(.semibold, size: 15))
                        .foregroundStyle(.darkGray)
                    
                    HStack(spacing: 0) {
                        
                        if showPickerYear {
                            
                            Picker("연 등록", selection: $pickerYear) {
                                
                                ForEach(2000..<2025, id: \.self) { year in
                                    
                                    Text("\(String(format: "%04d", year))년")
                                        .font(Font.pretendard(.semibold, size: 17))
                                    
                                }
                            }
                            .frame(width: 75, height: 80)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerYear) { _ in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showPickerYear = false
                                }
                                
                                // 연도가 바뀔 때마다 departTime 적용
                                addOOTDVM.ootdDepartTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerDepartTime) ?? 0
                                
                                addOOTDVM.ootdArrivalTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerArrivalTime) ?? 0

                                Task {
                                    
                                    await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
                                }
                                
                                print("바뀐 pickerYear: \(pickerYear)")
                            }
                            
                        } else {
                            
                            Text("\(String(format: "%04d", pickerYear))년")
                                .frame(width: 75)
                                .font(Font.pretendard(.semibold, size: 17))
                                .onTapGesture {
                                    showPickerYear = true
                                }
                        }
                        
                        if showPickerMonth {
                            
                            Picker("월 등록", selection: $pickerMonth) {
                                
                                ForEach(1..<13, id: \.self) { month in
                                    
                                    Text("\(month)월")
                                        .font(Font.pretendard(.semibold, size: 17))
                                    
                                }
                                
                            }
                            .frame(width: 55, height: 80)
                            .offset(x: -15)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerMonth) { _ in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                    showPickerMonth = false
                                    
                                    addOOTDVM.ootdDepartTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerDepartTime) ?? 0
                                    
                                    addOOTDVM.ootdArrivalTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerArrivalTime) ?? 0
                                    
                                    Task {
                                        
                                        await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
                                    }
                                    
                                }
                                
                            }
                            
                        } else {
                            Text("\(pickerMonth)월")
                                .frame(width: 55)
                                .offset(x: -15)
                                .font(Font.pretendard(.semibold, size: 17))
                                .onTapGesture {
                                    showPickerMonth = true
                                }
                            
                        }
                        
                        if showPickerDay {
                            
                            Picker("일 등록", selection: $pickerDay) {
                                ForEach(1..<32, id: \.self) { day in
                                    
                                    Text("\(day)일")
                                        .font(Font.pretendard(.semibold, size: 17))
                                    
                                }
                            }
                            .frame(width: 55, height: 80)
                            .offset(x: -30)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerDay) { _ in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showPickerDay = false
                                    
                                    addOOTDVM.ootdDepartTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerDepartTime) ?? 0
                                    
                                    addOOTDVM.ootdArrivalTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerArrivalTime) ?? 0

                                    Task {
                                        
                                        await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
                                    }
                                }
                                
                            }
                            
                        } else {
                            Text("\(pickerDay)일")
                                .frame(width: 55)
                                .offset(x: -30)
                                .font(Font.pretendard(.semibold, size: 17))
                                .onTapGesture {
                                    showPickerDay = true
                                }
                                
                        }
                        
                        
                    } // HStack
                    .frame(width: 175, height: 25)
//                    .padding(.horizontal, screenWidth / 6.5)
                    
                    HStack {
                        
                        Text("나간 시간")
                            .frame(width: 90)
                            .font(Font.pretendard(.semibold, size: 15))
                            .foregroundStyle(.main)
                        
//                            .padding(.trailing, 12.5)
                        
                        if showPickerDepartTime {
                            
                            Picker("나간 시간 등록", selection: $pickerDepartTime) {
                                
                                ForEach(0..<24) { hour in
                                    
                                    if hour > 11 {
                                        
                                        if hour == 12 {
                                            Text("오후 12시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        } else {
                                            Text("오후 \(hour - 12)시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        }
                                        
                                    } else {
                                        
                                        if hour == 0 {
                                            Text("오전 12시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        } else {
                                            Text("오전 \(hour)시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        }
                                    }
                                }
                                
                            }
                            .frame(width: 90, height: 60)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerDepartTime) { _ in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                    showPickerDepartTime = false
                                    
                                    print("나간 시간: \(pickerDepartTime)")
                                    
                                    addOOTDVM.ootdDepartTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerDepartTime) ?? 0
                                    
                                    Task {
                                        
                                        await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
                                    }
                                }
                                
                            }
                            
                        } else {
                         
                            if pickerDepartTime > 11 {
                                
                                if pickerDepartTime == 12 {
                                    Text("오후 \(pickerDepartTime)시")
                                        .frame(width: 90)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        
                                        .onTapGesture {
                                            showPickerDepartTime = true
                                        }
                                } else {
                                    Text("오후 \(pickerDepartTime - 12)시")
                                        .frame(width: 90)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .onTapGesture {
                                            showPickerDepartTime = true
                                        }
                                }
                                
                            } else {
                                if pickerDepartTime == 0 {
                                    
                                    Text("오전 12시")
                                        .frame(width: 90)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        
                                        .onTapGesture {
                                            showPickerDepartTime = true
                                        }
                                    
                                } else {
                                    Text("오전 \(pickerDepartTime)시")
                                        .frame(width: 90)
                                        .font(Font.pretendard(.semibold, size: 15))
                                       
                                        .onTapGesture {
                                            showPickerDepartTime = true
                                        }
                                }
                            }
                        }
                        
                        
                    } // HStack
                    .padding(.top, 20)
                    .frame(height: 25)
                    .offset(x: -15)
                    
                    HStack {
                        
                        Text("들어온 시간")
                            .frame(width: 100)
                            .font(Font.pretendard(.semibold, size: 15))
                            .foregroundStyle(.main)
                        
                        if showPickerArrivalTime {
                            
                            Picker("들어온 시간 등록", selection: $pickerArrivalTime) {
                                
                                ForEach(0..<24) { hour in
                                    
                                    if hour > 11 {
                                        
                                        if hour == 12 {
                                            Text("오후 12시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        } else {
                                            Text("오후 \(hour - 12)시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        }
                                        
                                    } else {
                                        
                                        if hour == 0 {
                                            Text("오전 12시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        } else {
                                            Text("오전 \(hour)시")
                                                .font(Font.pretendard(.semibold, size: 15))
                                                .tag(hour)
                                        }
                                    }
                                }
                                
                            }
                            .frame(width: 90, height: 75)
                            .offset(x: -10)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerArrivalTime) { _ in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                    showPickerArrivalTime = false
                                    
                                    print("들어온 시간: \(pickerArrivalTime)")
                                    
                                    addOOTDVM.ootdArrivalTime = epochTimeFrom(year: pickerYear, month: pickerMonth, day: pickerDay, hour: pickerArrivalTime) ?? 0
                                    
                                    Task {
                                        
                                        await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
                                    }
                                }
                                
                            }
                            
                        } else {
                         
                            if pickerArrivalTime > 11 {
                                
                                if pickerArrivalTime == 12 {
                                    Text("오후 \(pickerArrivalTime)시")
                                        .frame(width: 90)
                                        .offset(x: -10)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        
                                        .onTapGesture {
                                            showPickerArrivalTime = true
                                        }
                                } else {
                                    Text("오후 \(pickerArrivalTime - 12)시")
                                        .frame(width: 90)
                                        .offset(x: -10)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .onTapGesture {
                                            showPickerArrivalTime = true
                                        }
                                }
                                
                            } else {
                                if pickerArrivalTime == 0 {
                                    
                                    Text("오전 12시")
                                        .frame(width: 90)
                                        .offset(x: -10)
                                        .font(Font.pretendard(.semibold, size: 15))
                                        
                                        .onTapGesture {
                                            showPickerArrivalTime = true
                                        }
                                    
                                } else {
                                    Text("오전 \(pickerArrivalTime)시")
                                        .frame(width: 90)
                                        .offset(x: -10)
                                        .font(Font.pretendard(.semibold, size: 15))
                                       
                                        .onTapGesture {
                                            showPickerArrivalTime = true
                                        }
                                }
                            }
                            
                        }
                        
                        
                    } // HStack
                    .padding(.top, 15)
                    .frame(height: 25)
                    .offset(x: -15)
                    
                    Spacer()

                } // VStack

                
            }// HStack
            .padding(.horizontal, 10)
            .padding(.leading, 30)
            
            HStack {
                
//                HStack {
//                    Image("\(Weather.getTy)")
//                }
                
                HStack {
                    
                    Text("\(addOOTDVM.ootdLowestTemp)°C")
                        .foregroundStyle(.blue)
                        .font(Font.pretendard(.bold, size: 14))
                    
                    Text("/")
                        .font(Font.pretendard(.bold, size: 14))
                    
                    Text("\(addOOTDVM.ootdHighestTemp)°C")
                        .foregroundStyle(.red)
                        .font(Font.pretendard(.bold, size: 14))
                    
                    Weather(rawValue: addOOTDVM.ootdWeather)?.imageMain
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                .offset(y: 5)
    
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
                            .foregroundStyle(locationSearchText == "지역 검색" ? .main : .black)
                        
                        Image("location")
                    }
                }
                
            }
            .padding(.top, 5)
            
            HStack {
                
                Text("입은 옷 정보")
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .font(Font.pretendard(.semibold, size: 17))
                
                Spacer()
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
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    ForEach(ootdClothes.indices, id: \.self) { index in
                        
                        HStack {
                            
                            Text(ootdClothes[index])
                                .font(Font.pretendard(.semibold, size: 13))

                            Button {

                                ootdClothes.remove(at: index)
                                addOOTDVM.ootdWearingList.remove(at: index)


                            } label: {
                                Image("xBtn")
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
            
            print("ootdLat: \(ootdLat)")
            
            Task {
                
                await addOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: addOOTDVM.ootdDepartTime, arrivalTime: addOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
            
        }
        .padding(.horizontal, 20)
        .navigationTitle("내 OOTD 추가하기")
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
                .presentationDetents([.height(screenHeight / 4)])
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
        // 화면이 나타날 때
        .onAppear {
            wholeVM.isTabBarHidden = true
            
            // 현재 시간을 불러오고 Picker 설정
            extractDateComponents()
            
            print("현재 날짜: \(pickerYear), \(pickerMonth), \(pickerDay)")

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
    
    func extractDateComponents() {
        
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        pickerYear = calendar.component(.year, from: now)
        pickerMonth = calendar.component(.month, from: now)
        pickerDay = calendar.component(.day, from: now)
        pickerDepartTime = calendar.component(.hour, from: now)
        pickerArrivalTime = calendar.component(.hour, from: now)
    }
    
    func epochTimeFrom(year: Int, month: Int, day: Int, hour: Int) -> Int? {
        
        var calendar = Calendar.current
        
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        
        guard let date = calendar.date(from: components) else { return nil }
        
        return Int(date.timeIntervalSince1970) - 32400
        
    }
}

#Preview {
    AddOOTDView(pickerYear: 2024, pickerMonth: 5, pickerDay: 23, pickerDepartTime: 9, pickerArrivalTime: 12)
}
