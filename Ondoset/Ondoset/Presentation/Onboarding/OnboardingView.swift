//
//  OnboardingView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI

enum QuestionStatus {
    
    case before
    case progress
    case done
}

struct OnboardingView: View {
    
    @State var btnStatus: BtnStatus = .off
    @State var answerList = [Int:Int]()
    @State var questionStatus: [Int: QuestionStatus] = [1: .progress, 2: .before, 3: .before, 4: .before]
    
    @StateObject var onboardingVM: OnboardingViewModel = .init()
    
    let questionList: [String] = ["질문 1", "질문 2", "질문 3", "질문 4"]
    let answerOption: [String] = ["매우 그렇지 않다", "그렇지 않다", "보통이다", "그렇다", "매우 그렇다"]
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                Text("시작하기 전 몇 가지만 여쭤볼게요")
                    .font(Font.pretendard(.bold, size: 20))
                
                VStack {
                    Text("답변해주신 내용은")
                        .font(Font.pretendard(.semibold, size: 17))
                    Text("앞으로의 코디 추천에 사용돼요")
                        .font(Font.pretendard(.semibold, size: 17))
                }
                .padding(.top, 12)
                .padding(.bottom, 14)
                
                ForEach(0..<4, id: \.self) { question in
                    
                    if answerList[question+1] == nil && questionStatus[question+1] == .before {
                        
                        HStack {
                            
                            Text(questionList[question])
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                        }
                        .frame(width: 350, height: 40)
                        
                    } else if questionStatus[question+1] == .progress {
                        
                        VStack(alignment: .leading) {

                           Text(questionList[question])
                               .font(Font.pretendard(.semibold, size: 17))

                           HStack(spacing: 25) {

                               ForEach(0..<5, id: \.self) { index in

                                   VStack(spacing: 0) {
                                       Circle()
                                           .frame(width: 32, height: 32)
                                           .foregroundStyle(.white)
                                           .overlay(
                                               Circle().stroke(Color.mainLight, lineWidth: 2)
                                           )

                                       Text(answerOption[index])
                                           .font(Font.pretendard(.regular, size: 10))
                                           .foregroundStyle(.black)
                                           .padding(.top, 12)

                                   }
                                   .onTapGesture {
                                       self.answerList[question+1] = index + 1
                                       self.questionStatus[question + 2] = .progress

                                       self.questionStatus[question+1] = .done
                                   }
                               }
                           }
                       }
                       .frame(width: 350, height: 140)
                       .background(Color(hex: 0xEDEEFA))
                       .cornerRadius(15)
                       .shadow(color: Color(hex: 0xEDEEFA), radius: 4)
                        
                        
                    } else if answerList[question+1] != nil && questionStatus[question+1] == .done {
                        
                        VStack(spacing: 0) {

                            HStack {
                                Text(questionList[question])
                                    .padding(.leading, 10)
                                Spacer()
                            }

                            HStack {
                                // "여기"
                                ForEach(0..<5, id: \.self) { index in

                                    Spacer()

                                    if answerList[question+1] == index+1 {

                                        Circle()
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(.main)

                                        Spacer()

                                    } else {

                                        Circle()
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(.lightGray)

                                        Spacer()
                                    }
                                }
                            }
                            .padding(.vertical, 24)

                        }
                        .frame(width: 350)
                        .onTapGesture {
                            
                            for i in 1...4 {
                                if i != (question+1) {
                                    
                                    if answerList[question+1] == nil {
                                        self.questionStatus[i] = .before
                                    } else {
                                        self.questionStatus[i] = .done
                                    }
                                    
                                    
                                }
                            }
                            
                            self.questionStatus[question+1] = .progress
                        }
                    }
                }
                
                
//                ForEach(0..<4, id: \.self) { question in
//                    
//                    if questionStatus[question+1] == .progress {
//                        
//                        VStack(alignment: .leading) {
//
//                            Text(questionList[question])
//                                .font(Font.pretendard(.semibold, size: 17))
//                                
//                            HStack(spacing: 25) {
//                                
//                                ForEach(0..<5, id: \.self) { index in
//                                    
//                                    VStack(spacing: 0) {
//                                        Circle()
//                                            .frame(width: 32, height: 32)
//                                            .foregroundStyle(.white)
//                                            .overlay(
//                                                Circle().stroke(Color.mainLight, lineWidth: 2)
//                                            )
//                                            
//                                        Text(answerOption[index])
//                                            .font(Font.pretendard(.regular, size: 10))
//                                            .foregroundStyle(.black)
//                                            .padding(.top, 12)
//                                        
//                                    }
//                                    .onTapGesture {
//                                        self.answerList[question+1] = index + 1
//                                        self.questionStatus[question + 2] = .progress
//                                        
//                                        self.questionStatus[question+1] = .done
//                                        
//                                    }
//                                }
//                            }
//                        }
//                        .frame(width: 350, height: 140)
//                        .background(Color(hex: 0xEDEEFA))
//                        .cornerRadius(15)
//                        .shadow(color: Color(hex: 0xEDEEFA), radius: 4)
//                        
//                        
//                    } else if questionStatus[question+1] == .before {
//                        
//                        HStack {
//                            
//                            Text(questionList[question])
//                                .padding(.leading, 10)
//                            
//                            Spacer()
//                            
//                        }
//                        .frame(width: 350, height: 40)
//                        
//                    } else if questionStatus[question+1] == .done {
//                        
//                        VStack(spacing: 0) {
//                            
//                            HStack {
//                                Text(questionList[question])
//                                    .padding(.leading, 10)
//                                Spacer()
//                            }
//                            
//                            HStack {
//                                // "여기"
//                                ForEach(0..<5, id: \.self) { index in
//                                    
//                                    Spacer()
//                                    
//                                    if answerList[question+1] == index+1 {
//                                        
//                                        Circle()
//                                            .frame(width: 32, height: 32)
//                                            .foregroundStyle(.main)
//                                        
//                                        Spacer()
//                                        
//                                    } else {
//                                        
//                                        Circle()
//                                            .frame(width: 32, height: 32)
//                                            .foregroundStyle(.lightGray)
//                                        
//                                        Spacer()
//                                    }
//                                }
//                            }
//                            .padding(.vertical, 24)
//                            
//                        }
//                        .frame(width: 350)
//                        .onTapGesture {
//                            
//                            self.questionStatus[question+1] = .progress
//                            
//                            
//                        }
//                    }
//                }
            }
            .padding(.top, 50)
            
            
            ButtonComponent(btnStatus: $btnStatus, width: 340, btnText: "시작하기", radius: 15) {
            
                // 온보딩 결과 제출 API
                // OndosetHome 화면으로 이동
                // @AppStorage, UserDefaults 이용
                
            }
        }
        .onAppear {
            answerList[1] = 0
        }
    }
}

#Preview {
    OnboardingView()
}
