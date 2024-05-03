//
//  OOTDItemView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/29/24.
//

import SwiftUI
import Kingfisher

struct OOTDItemView: View {
    
    let ootdId: Int
    let ootdImageURL: String
    let dateString: String
    let lowestTemp: Int
    let highestTemp: Int
    
    let memberId = UserDefaults.standard.integer(forKey: "memberId")
    
    @StateObject var ootdItemVM: OOTDItemViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    
                    if let imageURL = ootdItemVM.ootdItem?.imageURL, let url = URL(string: imageURL) {
                        
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth / 8)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay {
                                Circle().stroke(.main, lineWidth: 0.5)
                            }
                        
                    } else {
                        Image("basicProfileIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth / 7.8)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay {
                                Circle().stroke(.main, lineWidth: 0.5)
                            }
                    }
                    
                    Text(ootdItemVM.ootdItem?.nickname ?? "사용자 닉네임")
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    if memberId != ootdItemVM.ootdItem?.memberId {
                        
                        FollowingBtnComponent(isFollowing: $ootdItemVM.isFollowing) {

                            if ootdItemVM.isFollowing {
                                
                                Task {
                                    await ootdItemVM.cancelFollowOther()
                                }
                                
                            } else {
                                Task {
                                    await ootdItemVM.followOther()
                                }
                            }
                        }
                        
                    } else {
                        
                        Menu(content: {
                            Button(action: {
                                
                            }) {
                                Text("옷 정보 수정하기")
                                
                            }
                            
                            Button(role: .destructive,
                                   action: {
                                
                            }) {
                                Text("OOTD 삭제하기")
                            }
                        }, label: {
                            Image(systemName: "ellipsis")
                                .frame(width:24, height: 24)
                                .rotationEffect(.degrees(90))
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        })
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 13)
                
                KFImage(URL(string: ootdImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth)
                    
                HStack(spacing: 8) {
                    
                    Text("\(dateString)")
                        .font(Font.pretendard(.medium, size: 13))
                        .foregroundStyle(.darkGray)
                    
                    if let weatherString = ootdItemVM.ootdItem?.weather, let weather = Weather(rawValue: weatherString) {
                        
                        weather.imageMain
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                    }
                    
                    HStack(spacing: 0) {
                        Text("\(lowestTemp)°C")
                            .font(Font.pretendard(.semibold, size: 13))
                            .foregroundStyle(.min)
                        
                        Text(" / ")
                            .font(Font.pretendard(.semibold, size: 13))
                            
                        Text("\(highestTemp)°C")
                            .font(Font.pretendard(.semibold, size: 13))
                            .foregroundStyle(.max)
                    }
                    
                    Spacer()
                    
                    if memberId != ootdItemVM.ootdItem?.memberId {
                        
                        if ootdItemVM.ootdItem?.isLike == true {
                            
                            Image("ootdLikeFill")
                                .onTapGesture {
                                    Task {
                                        await ootdItemVM.cancelLikeOOTD(ootdId: ootdId)
                                    }
                                }
                            
                        } else {
                            
                            Image("ootdLike")
                                .onTapGesture {
                                    Task {
                                        await ootdItemVM.likeOOTD(ootdId: ootdId)
                                    }
                                }
                        }
                    }
                    
                    
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                
                VStack(spacing: 5) {
                    
                    HStack {
                        ForEach(ootdItemVM.ootdItem?.wearing ?? [], id: \.self) { cloth in
                            
                            Text("# \(cloth)")
                                .font(Font.pretendard(.semibold, size: 13))
                            
                        }
                        
                        Spacer()
                    }     
                }
                .padding(.horizontal, 24)
                
                                
            }
        }
        .onAppear {
            
            Task {
                await ootdItemVM.getOOTDItem(ootdId: ootdId)
            }
            
            wholeVM.isTabBarHidden = true
//            
//            print("현재 멤버 아이디: \(memberId)")
//            print("게시물 멤버 아이디: \(ootdItemVM.ootdItem?.memberId)")
//            print("게시물 :\(ootdItemVM.ootdItem)")
            
        }
        .navigationTitle("OOTD")
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
    }
}

#Preview {
    OOTDItemView(ootdId: 0, ootdImageURL: "", dateString: "2024", lowestTemp: 4, highestTemp: 15)
}
