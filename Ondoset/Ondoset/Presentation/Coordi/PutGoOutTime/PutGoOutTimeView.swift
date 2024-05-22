//
//  PutGoOutTimeView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/11/24.
//

import SwiftUI
import MapKit

struct PutGoOutTimeView: View {
    
    @Binding var selectedCoordiId: Int
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selecteddDays: Int
    @Binding var goOutRegioin: String
    @Binding var goOutDepartTime: Int       // 에포크 값
    @Binding var goOutArrivalTime: Int      // 에포크 값
    
    @State var pickerDepartTime: Int = 0        // 시간 피커 값
    @State var pickerArrivalTime: Int = 0       // 시간 피커 값
    
    @State var goOutLat: Double = 91.0
    @State var goOutLon: Double = 91.0
    
    @Binding var isPutGoOutTimeSheetPresented: Bool
    
    @State var isLocationViewSheetPresented: Bool = false
    
    @State var showDepartTimePicker: Bool = false
    @State var showArrivalTimePicker: Bool = false
    
    @State var isSaveBtnAvailable: Bool = true
    
    @StateObject var putGoOutTimeVM: PutGoOutTimeViewModel = .init()
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    
                    isPutGoOutTimeSheetPresented.toggle()
                    
                } label: {
                    Text("닫기")
                        .padding(.leading, 15)
                        .font(Font.pretendard(.regular, size: 17))
                        .foregroundStyle(.darkGray)
                }
                
                Spacer()

            }
            .padding(.top, 20)
            .overlay {
                
                Text("외출 시간 수정하기")
                    .font(Font.pretendard(.semibold, size: 17))
                    .foregroundStyle(.black)
                    .padding(.top, 20)
            }
            
            HStack {
                
                Text("외출시간")
                    .font(Font.pretendard(.semibold, size: 17))
                    
                Spacer()
                
                HStack {

                    Text(goOutRegioin)
                        .font(Font.pretendard(.semibold, size: 15))
                        .foregroundStyle(goOutRegioin == "지역 검색" ? .blue : .black)

                    Image("location")
                }
                .onTapGesture {
//                    isPutGoOutTimeSheetPresented = true
                    isLocationViewSheetPresented = true
                }
            }
            .padding(.horizontal, 20)
            
            
            HStack {
                
                VStack(spacing: 0) {
                    
                    Text("나간 시간")
                        .font(Font.pretendard(.semibold, size: 15))
                        .foregroundStyle(.darkGray)
                        .padding(.bottom, 5)

                    Text("\(String(format: "%04d", selectedYear)).\(selectedMonth).\(selecteddDays)")
                        .font(Font.pretendard(.semibold, size: 15))
                        .padding(.bottom, 3)
                       
                    Group {
                        
                        if showDepartTimePicker {
                            
                            Picker("시간 등록", selection: $pickerDepartTime) {
                                
                                ForEach(0..<24) { hour in
                                    
                                    if hour > 11 {
                                        
                                        if hour == 12 {
                                            Text("오후 12시")
                                                .tag(hour)
                                        } else {
                                            Text("오후 \(hour - 12)시")
                                                .tag(hour)
                                        }
                                    } else {
                                        
                                        if hour == 0 {
                                            Text("오전 12시")
                                                .tag(hour)
                                        } else {
                                            Text("오전 \(hour)시")
                                                .tag(hour)
                                        }
                                        
                                        
                                    }
                                }
                            }
                            .frame(height: 75)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerDepartTime) { _ in
                                
                                print("출발 시간: \(pickerDepartTime)")
                                
//                                departTime = epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay, hour: pickerDepartTime) ?? 0
//                                
//                                print(departTime)
//                                
//                                updateBtnAvailable()
                                
                                goOutDepartTime = epochTimeFrom(year: selectedYear, month: selectedMonth, day: selecteddDays, hour: pickerDepartTime) ?? 0
                                
                                print(goOutDepartTime)
                                
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
                    
                    Text("\(String(format: "%04d", selectedYear)).\(selectedMonth).\(selecteddDays)")
                        .font(Font.pretendard(.semibold, size: 15))
                        .padding(.bottom, 3)
                        
                    Group {
                        
                        if showArrivalTimePicker {
                            
                            Picker("시간 등록", selection: $pickerArrivalTime) {
                                
                                ForEach(0..<24) { hour in
                                    
                                    if hour > 11 {
                                        
                                        if hour == 12 {
                                            Text("오후 12시")
                                                .tag(hour)
                                        } else {
                                            Text("오후 \(hour - 12)시")
                                                .tag(hour)
                                        }
                                    } else {
                                        
                                        if hour == 0 {
                                            Text("오전 12시")
                                                .tag(hour)
                                        } else {
                                            Text("오전 \(hour)시")
                                                .tag(hour)
                                        }
                                    }
                                }
                            }
                            .frame(height: 75)
                            .pickerStyle(WheelPickerStyle())
                            .onChange(of: pickerArrivalTime) { _ in
                                
                                print("도착 시간: \(pickerArrivalTime)")
                                
//                                arrivalTime = epochTimeFrom(year: coordiYear, month: coordiMonth, day: coordiDay, hour: pickerArrivalTime) ?? 0
//                                
//                                print(arrivalTime)
//                                
//                                updateBtnAvailable()
                                
                                goOutArrivalTime = epochTimeFrom(year: selectedYear, month: selectedMonth, day: selecteddDays, hour: pickerArrivalTime) ?? 0
                                
                                print(goOutArrivalTime)
                                
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
            
            Spacer()
            
            ButtonComponent(isBtnAvailable: $isSaveBtnAvailable, width: screenWidth - 50, btnText: "저장하기", radius: 15) {
                
                Task {
                    
                    let result = await putGoOutTimeVM.setCoordiTime(coordiId: selectedCoordiId, lat: goOutLat, lon: goOutLon, region: goOutRegioin, departTime: goOutDepartTime, arrivalTime: goOutArrivalTime)
                    
                    if result {
                        
                        isPutGoOutTimeSheetPresented = false
                        
                    }
                }
            }
            
            Spacer()
    
            
        }
        .sheet(isPresented: $isLocationViewSheetPresented) {
            
            LocationView(locationSearchText: $goOutRegioin, lat: $goOutLat, lon: $goOutLon, isLocationViewSheetPresented: $isLocationViewSheetPresented)
                .presentationDetents([.height(screenHeight / 4)])
        }
        
        .onAppear {
            
            fetchCoordinates {
                print("연도: \(selectedYear)")
                print("월: \(selectedMonth)")
                print("일: \(selecteddDays)")
                print("지역: \(goOutRegioin)")
                print("외출 출발 시간: \(goOutDepartTime)")
                print("외출 도착 시간; \(goOutArrivalTime)")
                
                print("초기 위도: \(goOutLat)")
                print("초기 경도: \(goOutLon)")
            }
            
            pickerDepartTime = extractHour(from: TimeInterval(goOutDepartTime))
            pickerArrivalTime = extractHour(from: TimeInterval(goOutArrivalTime))
            
            print("출발 시간: \(pickerDepartTime)")
            print("도착 시간: \(pickerArrivalTime)")
            
            
        }
        .onChange(of: goOutRegioin) { _ in
            
            print("지역: \(goOutRegioin)")
            
        }
        .onChange(of: goOutDepartTime) { _ in
            
            print("출발 시간: \(goOutDepartTime)")
        }
        .onChange(of: goOutArrivalTime) { _ in
            
            print("도착 시간: \(goOutArrivalTime)")
            
        }
        
    }

    // 위치 정보 불러오기
    func fetchCoordinates(completion: @escaping () -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = goOutRegioin

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let firstItem = response?.mapItems.first, let location = firstItem.placemark.location {
                DispatchQueue.main.async {
                    self.goOutLat = location.coordinate.latitude
                    self.goOutLon = location.coordinate.longitude
                    completion() // 완료 핸들러 호출
                }
            }
        }
    }
    
    // 에포크타임으로부터 시간(hour) 추출
    func extractHour(from epochTime: TimeInterval) -> Int {
        let date = Date(timeIntervalSince1970: epochTime)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
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
    PutGoOutTimeView(selectedCoordiId: .constant(0), selectedYear: .constant(2024), selectedMonth: .constant(5), selecteddDays: .constant(24) , goOutRegioin: .constant("경기도 의정부시"), goOutDepartTime: .constant(5), goOutArrivalTime: .constant(9), isPutGoOutTimeSheetPresented: .constant(true))
}
