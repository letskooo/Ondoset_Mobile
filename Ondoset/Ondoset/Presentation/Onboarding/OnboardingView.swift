//
//  OnboardingView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var age: Int = -1                 // 나이
    @State var sex: Int = -1                 // 남성: 0  여성: 1
    @State var height: Int = -1              // 키
    @State var weight: Int = -1              // 몸무게
    @State var activity: Int = -1    // 활동 수준 질문
    @State var goingOut: Int = -1             // 야외 노출 시간 질문
    
    @State var agePickerState = false
    
    @State var maleSelected = false
    @State var femaleSelected = false
    @State var activitySelected: [Int: Bool] = [0:false, 1:false, 2:false, 3:false, 4:false]
    @State var goingOutSelected: [Int: Bool] = [0:false, 1:false, 2:false, 3:false]
    
    @State var heightPickerState = false
    
    @State var weightPickerState = false
    
    let activityOption: [String] = ["가벼운 운동", "격한 운동", "걷기", "특정 장소에 머무름", "대중 교통"]
    let goingOutOption: [String] = ["15분 미만", "15분 이상 30분 미만", "30분 이상 60분 미만", "60분 이상"]
    
    @State var isBtnAvailable: Bool = false
    
    
    @StateObject var onboardingVM: OnboardingViewModel = .init()
    
    var body: some View {
        
        VStack{
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    
                    Text("시작하기 전 몇 가지만 여쭤볼게요")
                        .font(Font.pretendard(.bold, size: 20))
     
                    VStack(spacing: 5) {
                        Text("답변해주신 내용은")
                            .font(Font.pretendard(.semibold, size: 17))
                        Text("앞으로의 코디 추천에 사용돼요")
                            .font(Font.pretendard(.semibold, size: 17))
                    }
                    .padding(.bottom, 20)
                    
                    
                    // MARK: 나이 질문
                    VStack(spacing: 25) {
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("나이")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 8)
                            
                            HStack(spacing: 8) {
                                
                                Spacer()
                                
                                if !agePickerState {
                                    
                                    Text(age == -1 ? "(만) 나이를 입력해주세요" : "만 \(age)세")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .padding(.trailing, 15)
                                    
                                } else {
                                    
                                    Picker("나이 선택", selection: $age) {
                                        
                                        ForEach(0...120, id: \.self) { number in
                                            Text("\(number)")
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .onChange(of: age) { _ in
                                        agePickerState = false
                                    }
                                }
                            }
                            .frame(width: screenWidth - 65, height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                agePickerState = true
                            }
                            
                        }
                        .frame(width: screenWidth - 40, height: 115)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                        
                        
                        // MARK: 성별 질문
                        VStack(alignment: .leading) {
                            
                            Text("성별")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 8)
                            
                            HStack(spacing: 40) {
                                
                                HStack(spacing: 10) {
                                                                   
                                    Circle()
                                        .fill(maleSelected ? .mainLight : .white)
                                        .frame(width: 27, height: 27)
                                        .overlay(
                                            Circle().stroke(.mainLight)
                                        )
                                    
                                    Text("남성")
                                        .font(Font.pretendard(.semibold, size: 15))
                                }
                                .onTapGesture {
                                    maleSelected = true
                                    femaleSelected = false
                                    sex = 0
                                }
                                
                                
                                HStack(spacing: 10) {
                                    
                                    Circle()
                                        .fill(femaleSelected ? .mainLight : .white)
                                        .frame(width: 27, height: 27)
                                        .overlay(
                                            Circle().stroke(.mainLight)
                                        )
                                    
                                    Text("여성")
                                        .font(Font.pretendard(.semibold, size: 15))
                                }
                                .onTapGesture {
                                    femaleSelected = true
                                    maleSelected = false
                                    sex = 1
                                }
                                
                            }
                            .frame(width: screenWidth - 65, height: 50)
                        }
                        .frame(width: screenWidth - 40, height: 115)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                        
                        
                        // MARK: 키 질문
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("키")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 8)
                            
                            HStack(spacing: 8) {
                                
                                Spacer()
                                
                                if !heightPickerState {
                                    
                                    Text(height == -1 ? "키를 입력해주세요(cm)" : "\(height) cm")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .padding(.trailing, 15)
                                    
                                } else {
                                    
                                    Picker("키 선택", selection: $height) {
                                        
                                        ForEach(100...250, id: \.self) { number in
                                            Text("\(number)")
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .onChange(of: height) { _ in
                                        heightPickerState = false
                                    }
                                }
                            }
                            .frame(width: screenWidth - 65, height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                heightPickerState = true
                            }
                            
                        }
                        .frame(width: screenWidth - 40, height: 115)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                        
                        
                        // MARK: 체중 질문
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("체중")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 8)
                            
                            HStack(spacing: 8) {
                                
                                Spacer()
                                
                                if !weightPickerState {
                                    
                                    Text(weight == -1 ? "몸무게를 입력해주세요(kg)" : "\(weight) kg")
                                        .font(Font.pretendard(.semibold, size: 15))
                                        .foregroundStyle(.darkGray)
                                        .padding(.trailing, 15)
                                    
                                } else {
                                    
                                    Picker("몸무게 선택", selection: $weight) {
                                        
                                        ForEach(30...200, id: \.self) { number in
                                            Text("\(number)")
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .onChange(of: weight) { _ in
                                        weightPickerState = false
                                    }
                                }
                            }
                            .frame(width: screenWidth - 65, height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                weightPickerState = true
                            }
                            
                        }
                        .frame(width: screenWidth - 40, height: 115)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                        
                        
                        // MARK: 일반적인 활동 수준 질문
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("일반적인 활동 수준")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 30)
                                .padding(.bottom, 15)
                            
                            VStack(spacing: 30) {
                                ForEach(0..<activityOption.count, id: \.self) { index in
                                    
                                    HStack{
                                        
                                        Circle()
                                            .fill(activitySelected[index] ?? false ? .mainLight : .white)
                                            .frame(width: 27, height: 27)
                                            .overlay(
                                                Circle().stroke(.mainLight)
                                            )
                                        
                                        Text(activityOption[index])
                                            .font(Font.pretendard(.semibold, size: 17))
                                        
                                        Spacer()
                                    }
                                    .onTapGesture {
                                        
                                        for i in activitySelected.keys {
                                            activitySelected[i] = false
                                        }
                                        
                                        activitySelected[index] = true
                                        
                                        if let activitySelected = activitySelected.first(where: { $0.value == true})?.key {
                                            activity = activitySelected
                                        }
                                    }
                                }
                                
                            }
                            .frame(width: screenWidth - 65)
                            .padding(.leading, 40)
                        }
                        .frame(width: screenWidth - 40)
                        .padding(.vertical, 20)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                        
                        
                        // MARK: 야외 노출 시간 질문
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("야외 노출 시간")
                                .font(Font.pretendard(.semibold, size: 17))
                                .padding(.leading, 30)
                                .padding(.bottom, 15)
                            
                            VStack(spacing: 30) {
                                ForEach(0..<goingOutOption.count, id: \.self) { index in
                                    
                                    HStack{
                                        
                                        Circle()
                                            .fill(goingOutSelected[index] ?? false ? .mainLight : .white)
                                            .frame(width: 27, height: 27)
                                            .overlay(
                                                Circle().stroke(.mainLight)
                                            )
                                        
                                        Text(goingOutOption[index])
                                            .font(Font.pretendard(.semibold, size: 17))
                                        
                                        Spacer()
                                    }
                                    .onTapGesture {
                                        
                                        for i in goingOutSelected.keys {
                                            goingOutSelected[i] = false
                                        }
                                        
                                        goingOutSelected[index] = true
                                        
                                        if let goingOutSelected = goingOutSelected.first(where: { $0.value == true})?.key {
                                            goingOut = goingOutSelected
                                        }
                                    }
                                }
                            }
                            .frame(width: screenWidth - 65)
                            .padding(.leading, 40)
                        }
                        .frame(width: screenWidth - 40)
                        .padding(.vertical, 20)
                        .background(.ondosetBackground)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.2), radius: 5, y: 5)
                    }
                    
                    ButtonComponent(isBtnAvailable: $isBtnAvailable, width: screenWidth - 40, btnText: "시작하기", radius: 15) {
                        
                        Task {
                            
                            await onboardingVM.saveOnboarding(age: age, sex: sex, height: height, weight: weight, activity: activity, goingOut: goingOut)
                        }
//                        print("나이: \(age)")
//                        print("성별: \(sex)")
//                        print("키: \(height)")
//                        print("체중: \(weight)")
//                        print("일반적인 활동 수준: \(activity)")
//                        print("야외 노출 시간: \(goingOut)")
                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                }
                .padding(.top, 50)
            }
            .onChange(of: age) { _ in updateButtonAvailability() }
            .onChange(of: sex) { _ in updateButtonAvailability() }
            .onChange(of: height) { _ in updateButtonAvailability() }
            .onChange(of: weight) { _ in updateButtonAvailability() }
            .onChange(of: activity) { _ in updateButtonAvailability() }
            .onChange(of: goingOut) { _ in updateButtonAvailability() }
        }
        .padding(.top, 40)
    }
    
    // 시작하기 버튼 활성화 여부 업데이트 메소드
    func updateButtonAvailability() {
        
        isBtnAvailable = (age != -1 && sex != -1 && height != -1 && weight != -1 && activity != -1 && goingOut != -1 ? true : false)
    }
}

#Preview {
    OnboardingView()
}
