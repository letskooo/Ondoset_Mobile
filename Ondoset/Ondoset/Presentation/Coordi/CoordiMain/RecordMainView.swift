//
//  RecordMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct RecordMainView: View {
    
    @State var selectedDate: Date = Date()
    @State var selectedYear: Int = 2024
    @State var selectedMonth: Int = 1
    @State var selectedDay: Int = 1
    let months: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 10) {
                
                RecordMainHeaderView(selectedDate: $selectedDate)
                    .onChange(of: selectedDate) { date in
                        
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day], from: date)
                        
                        if let yearValue = components.year, let monthValue = components.month, let dayValue = components.day {
                            
                            selectedYear = yearValue
                            selectedMonth = monthValue
                            selectedDay = dayValue
                        }
                        
                        print("선택된 연도: \(selectedYear)")
                        print("선택된 월: \(selectedMonth)")
                        print("선택된 일: \(selectedDay)")
                    }
                
                VStack {
                    
                    GeometryReader { geometry in
                        ScrollViewReader { scrollView in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(months.indices, id: \.self) { index in
                                        Text("\(months[index])월")
                                            .font(self.selectedMonth == index ? Font.pretendard(.semibold, size: 17) : Font.pretendard(.medium, size: 15))
                                            .foregroundStyle(self.selectedMonth == index ? .black : .darkGray)
                                            .id(index)
                                            .frame(width: 55, height: 40)
                                            .padding(.horizontal, 10)
                                            .background(self.selectedMonth == index ? Color(hex: 0xA8B9F5) : Color.clear)
                                            .cornerRadius(30)
                                            .onAppear {
                                                
                                                self.selectedMonth = index + 1
                                                scrollView.scrollTo(self.selectedMonth - 1, anchor: .center)
                                            }
                                            .onTapGesture {
                                                withAnimation {
                                                    self.selectedMonth = index + 1
                                                    updateDate()
                                                    scrollView.scrollTo(index, anchor: .center)
                                                    
                                                    
                                                    
                                                }
                                            }
                                            .background(GeometryReader { geo in
                                                    Color.clear.preference(key: ViewOffsetKey.self, value: [geo.frame(in: .global).midX])
                                                })
                                    }
                                }
                                .frame(width: geometry.size.width + screenWidth * 2, height: 70)
                                .padding(.horizontal, geometry.size.width / 3)
                                .background(Color(hex: 0xEDEEFA))
                            }
                        }
                        .onPreferenceChange(ViewOffsetKey.self) { offsets in
                            // 화면상 가운데를 정함
                            let center = geometry.size.width / 2 + geometry.frame(in: .global).minX
                            // 중심과 가장 가까운 월을 찾음
                            let closest = offsets.enumerated().min(by: { abs($0.1 - center) < abs($1.1 - center) })?.0 ?? self.selectedMonth
                            self.selectedMonth = closest
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                // 2초 뒤에 실행될 코드
                                print("2초가 지났습니다.")
                                // 여기에 특정 메소드 호출 추가
                                // 예: self.callYourMethod()
                            }
            
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                
                let currentDate = Date()
                
                let calendar = Calendar.current
                
                selectedYear = calendar.component(.year, from: currentDate)
                selectedMonth = calendar.component(.month, from: currentDate)
            }
        }
    }
    
    func updateDate() {
        if let newDate = Calendar.current.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: selectedDay)) {
            selectedDate = newDate
        }
    }
}

struct RecordMainHeaderView: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image("calendar")
            
            DatePicker("외출 출발 시간", selection: $selectedDate, displayedComponents: .date).labelsHidden()
            
            Spacer()
        }
        .frame(width: screenWidth)
        .padding(.leading, 40)
    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

#Preview {
    RecordMainView(selectedMonth: 0)
}
