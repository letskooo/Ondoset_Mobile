//
//  PutOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import SwiftUI
import Kingfisher
import MapKit

/// OOTD 수정하기 화면

struct PutOOTDView: View {
    
    // 수정하고자 하는 OOTD 아이디
    let ootdId: Int
    
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
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var putOOTDVM: PutOOTDViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .top) {
                
                // 새로운 OOTD 이미지를 선택한 경우
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
                                putOOTDVM.ootdImage = imageData
                            }

                        }
                        .onChange(of: ootdImage) { image in

                            print(image)

                            // MARK: 나중에 화질 구리면 0.1 -> 0.7로 수정
                            if let imageData = image.jpegData(compressionQuality: 0.1) {
                                putOOTDVM.ootdImage = imageData
                            }
                        }
                    
                } else {
                    // 기존 이미지
                    KFImage(URL(string: putOOTDVM.getOOTDforPut.imageURL))
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
                                
                        }
                        .padding(.top, 5)
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("외출 도착 시간")
                        DatePicker("외출 도착 시간", selection: $selectedArrivalDate).labelsHidden()
                            .frame(width: screenWidth / 4, height: 60)
                    }
                    .onChange(of: selectedArrivalDate) { date in
                        
            
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
                    
                    isLocationSearchSheetPresented = true
                    
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
                        
                        TextField("추가할 옷 이름을 입력해주세요", text: $putOOTDVM.addClothInputText)
            
                        Button {
                           
                            ootdClothes.append(putOOTDVM.addClothInputText)
                            putOOTDVM.ootdWearingList.append(putOOTDVM.addClothInputText)
                            putOOTDVM.addClothInputText = ""
                            
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
                                    
                                    // 선택한 옷 아이템을 화면상 옷 리스트에서 삭제
                                    ootdClothes.remove(at: index)
                                    
                                    // 선택한 옷 아이템을 뷰모델의 옷 리스트에서 삭제
                                    putOOTDVM.ootdWearingList.remove(at: index)
                                    
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
            
            ButtonComponent(isBtnAvailable: $putOOTDVM.isRegisterBtnAvailable, width: screenWidth - 50, btnText: "수정하기", radius: 15) {
                
                Task {
                    
                    // OOTD 수정하기 API 호출
                    let result = await putOOTDVM.putOOTD(ootdId: ootdId, isOOTDImageSelected: isOOTDImageSelected)
                    
                    // 성공했다면 뒤로가기
                    if result {
                        dismiss()
                    }
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
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
        // 화면이 나타날 때 처리
        .onAppear {
            
            // 화면이 나타날 때 OOTD 수정용 조회 API 호출
            Task {
                await putOOTDVM.getOOTDforPut(ootdId: ootdId)
                
                // 기존 OOTD의 시간을 DatePicker의 Date 타입으로 변환
                selectedDepartDate = Date(timeIntervalSince1970: TimeInterval(putOOTDVM.getOOTDforPut.departTime))
                
                selectedArrivalDate = Date(timeIntervalSince1970: TimeInterval(putOOTDVM.getOOTDforPut.arrivalTime))
                
                // 뷰모델의 OOTD 값을 기존 OOTD 값으로 지정
                putOOTDVM.ootdRegion = putOOTDVM.getOOTDforPut.region
                putOOTDVM.ootdDepartTime = putOOTDVM.getOOTDforPut.departTime
                putOOTDVM.ootdArrivalTime = putOOTDVM.getOOTDforPut.arrivalTime
                putOOTDVM.ootdWeather = putOOTDVM.getOOTDforPut.weather.rawValue
                putOOTDVM.ootdLowestTemp = putOOTDVM.getOOTDforPut.lowestTemp
                putOOTDVM.ootdHighestTemp = putOOTDVM.getOOTDforPut.highestTemp
                // 이미지는 생략
                putOOTDVM.ootdWearingList = putOOTDVM.getOOTDforPut.wearingList
                
                // 기존 OOTD의 지역을 화면에 나타냄
                locationSearchText = putOOTDVM.getOOTDforPut.region
                
                // 기존 OOTD의 옷 목록을 화면에 나타냄
                ootdClothes = putOOTDVM.getOOTDforPut.wearingList
                
                // 수정하기 버튼 활성화
                updateIsRegisterBtnAvailable()
                
                // 기존 OOTD 지역 좌표 정보 업데이트
                fetchCoordinates(completion: {
                    print("초기 위도: \(ootdLat)")
                    print("초기 경도: \(ootdLon)")
                })
            }
        }
        // 지역 정보 검색 화면 활성화
        .sheet(isPresented: $isLocationSearchSheetPresented) {
            
            LocationView(locationSearchText: $locationSearchText, lat: $ootdLat, lon: $ootdLon, isLocationViewSheetPresented: $isLocationSearchSheetPresented)
        }
        // 코디에서 불러오기 sheet 활성화
        .sheet(isPresented: $isSheetPresented) {
            GetCoordiforPutView(ootdClothes: $ootdClothes, putOOTDVM: putOOTDVM, isSheetPresented: $isSheetPresented)
        }
        // 사진을 선택했을 경우 이미지 피커 sheet 활성화
        .sheet(isPresented: $openPhoto) {

            ImagePicker(sourceType: .photoLibrary, selectedImage: $ootdImage)
        }
        // 사진이 선택되고 화면상 이미지 변경
        .onChange(of: ootdImage) { image in
            
            // 이미지 선택 상태 여부 -> true
            isOOTDImageSelected = true
            
            // 뷰모델의 ootdImage를 선택한 이미지로 설정
            if let imageData = image.jpegData(compressionQuality: 0.1) {
                putOOTDVM.ootdImage = imageData
            }
        }
        // DatePicker에서 시간을 바꿀 때
        .onChange(of: selectedDepartDate) { date in
            
            putOOTDVM.ootdDepartTime = dateToEpoch(selectedDate: date)
            
            // 시간이 바뀔 때마다 날씨 미리보기 API 호출
            Task {
                await putOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: putOOTDVM.ootdDepartTime, arrivalTime: putOOTDVM.ootdArrivalTime, location: locationSearchText)
            }

        }
        .onChange(of: selectedArrivalDate) { date in
            
            putOOTDVM.ootdArrivalTime = dateToEpoch(selectedDate: date)
            
            Task {
                await putOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: putOOTDVM.ootdDepartTime, arrivalTime: putOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
        }
        // 위치 정보가 바뀔 때마다 날씨 미리보기 API 호출
        .onChange(of: ootdLat) { _ in
            
            Task {
                await putOOTDVM.getOOTDWeather(lat: ootdLat, lon: ootdLon, departTime: putOOTDVM.ootdDepartTime, arrivalTime: putOOTDVM.ootdArrivalTime, location: locationSearchText)
            }
        }
        // 옷 리스트 목록에 옷이 없을 때 수정하기 버튼 비활성화
        .onChange(of: ootdClothes) { _ in
            
            updateIsRegisterBtnAvailable()
        }
    }
    
    func updateIsRegisterBtnAvailable() {
        putOOTDVM.isRegisterBtnAvailable = !ootdClothes.isEmpty
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
    
    // 위치 정보 불러오기
    func fetchCoordinates(completion: @escaping () -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = putOOTDVM.getOOTDforPut.region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let firstItem = response?.mapItems.first, let location = firstItem.placemark.location {
                DispatchQueue.main.async {
                    self.ootdLat = location.coordinate.latitude
                    self.ootdLon = location.coordinate.longitude
                    completion() // 완료 핸들러 호출
                }
            }
        }
    }
}

#Preview {
    PutOOTDView(ootdId: 0)
}
