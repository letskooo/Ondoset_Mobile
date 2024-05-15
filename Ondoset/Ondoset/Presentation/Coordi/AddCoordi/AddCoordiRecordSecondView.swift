//
//  AddCoordiRecordSecondView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/9/24.
//

import SwiftUI

struct AddCoordiRecordSecondView: View {
    
    // 선택된 지역
    
    @ObservedObject var addCoordiRecordVM: AddCoordiRecordViewModel
    
    // 외출 출발 시간
    @Binding var departTime: Int
    
    // 외출 출발 시간 피커 보이기 여부
    @State var showDepartTimePicker: Bool = false
    
    // 외출 도착 시간
    @Binding var arrivalTime: Int
    
    // 외출 도착 시간 피커 보이기 여부
    @State var showArrivalTimePicker: Bool = false
    
    @Binding var pickerDepartTime: Int
    @Binding var pickerArrivalTime: Int
    
    // 저장하기 버튼 활성화 여부
    @State private var isRegisterBtnAvailable: Bool = false
    
    // 지역 검색 뷰 활성화 여부
    @State var isLocationViewSheetPreented: Bool = false
    
    // 코디를 등록하려는 날짜
    @Binding var coordiYear: Int
    @Binding var coordiMonth: Int
    @Binding var coordiDay: Int
    
    // 과거 코디 기록 sheet 전체 내리기
    @Binding var isAddCoordiRecordSheetPresented: Bool
    
    @Binding var locationSearchText: String  // 장소 검색 텍스트
    @Binding var lat: Double                // 위도
    @Binding var lon: Double                // 경도
    
    @Environment(\.dismiss) private var dismiss

    let columns: [GridItem] = Array(repeating: .init(.fixed((screenWidth - 36)/3), spacing: 10), count: 3)
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("외출시간")
                    .font(Font.pretendard(.semibold, size: 17))
                    
                Spacer()
                
                HStack {

                    Text(locationSearchText)
                        .font(Font.pretendard(.semibold, size: 15))
                        .foregroundStyle(locationSearchText == "지역 검색" ? .blue : .black)

                    Image("location")
                }
                .onTapGesture {
//                    isPutGoOutTimeSheetPresented = true
                    isLocationViewSheetPreented = true
                }
            }
            .padding(.horizontal, 20)
            
            coordiTimeRegisterView
            
            VStack {
                
                Text("선택된 옷 조합")
                    .font(Font.pretendard(.semibold, size: 17))
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(addCoordiRecordVM.coordiClothesList, id: \.self) { cloth in
                            
                            ClothSearchComponent(clothes: cloth)
                            
                        }
                    }
                }
                
                
                ButtonComponent(isBtnAvailable: $isRegisterBtnAvailable, width: 340, btnText: "저장하기", radius: 15) {
                    
                    // 코디 기록 등록 API 호출
                    Task {
                        
                        let clothesList = addCoordiRecordVM.coordiClothesList.map { $0.clothesId }
                        
                        let result = await addCoordiRecordVM.setCoordiRecord(lat: lat, lon: lon, region: locationSearchText, departTime: departTime, arrivalTime: arrivalTime, clothesList: clothesList)
                            
                        if result {
                            
                            isAddCoordiRecordSheetPresented = false
                        }
                    }
                }
                
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
        }
        .navigationTitle("나의 코디 추가하기")
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
        .sheet(isPresented: $isLocationViewSheetPreented) {
            LocationView(locationSearchText: $locationSearchText, lat: $lat, lon: $lon, isLocationViewSheetPresented: $isLocationViewSheetPreented)
                .presentationDetents([.height(screenHeight / 2)])
        }
        .onChange(of: lat) { _ in
            print("위도: \(lat)")
            print("경도: \(lon)")
        }
        .onDisappear {
            
            // 여기서 CoordiMainView의 코디 기록 조회를 한 번 더 해줘야 할 수도...
            // 등록하자마자 등록된 걸 보기 위해서
            
        }
    }
    
    var coordiTimeRegisterView: some View {
        
        HStack {
            
            VStack(spacing: 0) {
                
                Text("나간 시간")
                    .font(Font.pretendard(.semibold, size: 15))
                    .foregroundStyle(.darkGray)
                    .padding(.bottom, 5)

                Text("\(String(format: "%04d", coordiYear)).\(coordiMonth).\(coordiDay)")
                    .font(Font.pretendard(.semibold, size: 15))
                    .padding(.bottom, 3)
                   
                Group {
                    
                    if showDepartTimePicker {
                        
                        Picker("시간 등록", selection: $pickerDepartTime) {
                            
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
                        .frame(width: 80, height: 75)
                        .pickerStyle(WheelPickerStyle())
                        .onChange(of: pickerDepartTime) { _ in
                            
                            print("출발 시간: \(pickerDepartTime)")
                            
                            departTime = epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay, hour: pickerDepartTime) ?? 0
                            
                            print(departTime)
                            
                            updateBtnAvailable()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showDepartTimePicker = false
                            }
                        }
                    } else {
                        
                        if pickerDepartTime == -1 {
                            Text("시간을 등록해주세요")
                                .font(Font.pretendard(.semibold, size: 15))
                                .foregroundStyle(.darkGray)
                                .onTapGesture {
                                    showDepartTimePicker = true
                                }
                        } else {
                            
                            if pickerDepartTime > 11 {
                                if pickerDepartTime == 12 {
                                    
                                    Text("오후 \(pickerDepartTime)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showDepartTimePicker = true
                                        }
                                    
                                } else {
                                    Text("오후 \(pickerDepartTime - 12)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showDepartTimePicker = true
                                        }
                                }
                            } else {
                                
                                if pickerDepartTime == 0 {
                                    
                                    Text("오전 12시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showDepartTimePicker = true
                                        }
                                    
                                } else {
                                    Text("오전 \(pickerDepartTime)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showDepartTimePicker = true
                                        }
                                }
                            }
                        }
                    }
                    
                } // Group
                .frame(width: 125, height: 25)
            }
            .padding(.vertical, 10)
            .frame(width: screenWidth / 2)
            .background(Color(hex: 0xEDEEFA))
            
            
            VStack(spacing: 0) {
                
                Text("들어온 시간")
                    .font(Font.pretendard(.semibold, size: 15))
                    .foregroundStyle(.darkGray)
                    .padding(.bottom, 5)
                
                Text("\(String(format: "%04d", coordiYear)).\(coordiMonth).\(coordiDay)")
                    .font(Font.pretendard(.semibold, size: 15))
                    .padding(.bottom, 3)
                    
                Group {
                    
                    if showArrivalTimePicker {
                        
                        Picker("시간 등록", selection: $pickerArrivalTime) {
                            
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
                        .frame(width: 80, height: 75)
                        .pickerStyle(WheelPickerStyle())
                        .onChange(of: pickerArrivalTime) { _ in
                            
                            print("도착 시간: \(pickerArrivalTime)")
                            
                            arrivalTime = epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay, hour: pickerArrivalTime) ?? 0
                            
                            print(arrivalTime)
                            
                            updateBtnAvailable()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showArrivalTimePicker = false
                            }
                        }
                        
                        
                    } else {
                        
                        if pickerArrivalTime == -1 {
                            Text("시간을 등록해주세요")
                                .font(Font.pretendard(.semibold, size: 15))
                                .foregroundStyle(.darkGray)
                                .onTapGesture {
                                    showArrivalTimePicker = true
                                }
                        } else {
                            
                            if pickerArrivalTime > 11 {
                                if pickerArrivalTime == 12 {
                                    
                                    Text("오후 \(pickerArrivalTime)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showArrivalTimePicker = true
                                        }
                                    
                                } else {
                                    Text("오후 \(pickerArrivalTime - 12)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showArrivalTimePicker = true
                                        }
                                }
                            } else {
                                
                                if pickerArrivalTime == 0 {
                                    
                                    Text("오전 12시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showArrivalTimePicker = true
                                        }
                                    
                                } else {
                                    Text("오전 \(pickerArrivalTime)시")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .onTapGesture {
                                            showArrivalTimePicker = true
                                        }
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                } // Group
                .frame(width: 125, height: 25)
            }
            .padding(.vertical, 10)
            .frame(width: screenWidth / 2)
        }
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
    
    func updateBtnAvailable() {
        
        if locationSearchText != "지역 검색" && departTime != 0 && arrivalTime != 0 {
            
            isRegisterBtnAvailable = true
            
        } else {
            isRegisterBtnAvailable = false
        }
    }
}

#Preview {
    AddCoordiRecordSecondView(addCoordiRecordVM: AddCoordiRecordViewModel(), departTime: .constant(0), arrivalTime: .constant(0), pickerDepartTime: .constant(-1), pickerArrivalTime: .constant(-1), coordiYear: .constant(5), coordiMonth: .constant(2024), coordiDay: .constant(5), isAddCoordiRecordSheetPresented: .constant(true), locationSearchText: .constant("지역 검색"), lat: .constant(0.0), lon: .constant(0.0))
}
