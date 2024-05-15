//
//  LocationView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/11/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @State var text: String = ""
    @Binding var locationSearchText: String
    
    @Binding var lat: Double
    @Binding var lon: Double
    
    @StateObject private var locationManager = LocationManager()
    
    @Binding var isLocationViewSheetPresented: Bool
    
    @State var isBtnAvailable: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button {
                    
                    isLocationViewSheetPresented.toggle()
                    
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
                
                Text("지역 검색하기")
                    .font(Font.pretendard(.semibold, size: 17))
                    .foregroundStyle(.black)
                    .padding(.top, 10)
            }
            
            HStack(spacing: 0) {
                
                TextField("ex) 서울특별시 강남구", text: $text, onCommit: fetchCoordinates)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: text) { _ in
                        
                        locationSearchText = text
                    }
                
                ButtonComponent(isBtnAvailable: $isBtnAvailable, width: 60, btnText: "확인", radius: 5) {
                    
                    fetchCoordinates()
                    
                    isLocationViewSheetPresented = false
                    
                }
            }
            .padding(.horizontal, 15)

            Spacer()
            
        }
        .onChange(of: text) { _ in
            
            if text != "" {
                isBtnAvailable = true
            }
        }
    }
    
    func fetchCoordinates() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationSearchText

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let firstItem = response.mapItems.first {
                let location = firstItem.placemark.location
                if let lat = location?.coordinate.latitude, let lon = location?.coordinate.longitude {
                    DispatchQueue.main.async {
//                            coordinates = "Latitude: \(lat), Longitude: \(lon)"
                        self.lat = lat
                        self.lon = lon
                        
                        print(self.lat)
                        print(self.lon)
                    }
                }
            }
        }
    }
}

#Preview {
    LocationView(locationSearchText: .constant(""), lat: .constant(0.0), lon: .constant(0.0), isLocationViewSheetPresented: .constant(true))
}
