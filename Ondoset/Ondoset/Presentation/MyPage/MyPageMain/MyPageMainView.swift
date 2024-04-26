//
//  MyPageMainView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import SwiftUI
import Kingfisher

struct MyPageMainView: View {
    
    @StateObject var myPageVM: MyPageMainViewModel = .init()
    
    private let dateFormatter = DateFormatter()
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                HStack {
                    
                    Spacer()
                
                    NavigationLink(destination: SettingView(myPageVM: myPageVM)) {
                        Image("setting")
                            .padding(.trailing, 16)
                    }
                    
                    
                }
                .frame(height: 30)
                .overlay {
                    Text(myPageVM.memberProfile?.memberId ?? "test1")
                        .font(Font.pretendard(.bold, size: 18))
                }
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        
                        HStack {
                            
                            if let imageURL = myPageVM.memberProfile?.profileImage, let url = URL(string: imageURL) {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 96, height: 96)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(.main, lineWidth: 0.5)
                                    }
                                    .padding(.leading, 35)
                                
                            } else {
                                
                                Image("testImage3")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 96, height: 96)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(.darkGray, lineWidth: 1)
                                    }
                                    .padding(.leading, 35)
            
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    
                                    Text("게시한 OOTD")
                                        .font(Font.pretendard(.regular, size: 15))
                                    
                                    Text("\(myPageVM.memberProfile?.ootdCount ?? 0)")
                                        .font(Font.pretendard(.bold, size: 17))
                                        .padding(.leading, 24)
                                }
                                
                                NavigationLink(destination: LikeOOTDView()) {
                                    
                                    HStack {
                                        
                                        Text("공감한 OOTD")
                                            .font(Font.pretendard(.regular, size: 15))
                                            .foregroundStyle(.black)
                                        
                                        Text("\(myPageVM.memberProfile?.likeCount ?? 0)")
                                            .font(Font.pretendard(.bold, size: 17))
                                            .padding(.leading, 24)
                                            .foregroundStyle(.black)
                                        
                                        Image("rightChevron2")
                                    }
                                }
                                
                                NavigationLink(destination: FollowingListView()) {
                                    
                                    HStack {
                                        
                                        Text("팔로우한 계정")
                                            .font(Font.pretendard(.regular, size: 15))
                                            .foregroundStyle(.black)
                                        
                                        Text("\(myPageVM.memberProfile?.followingCount ?? 0)")
                                            .font(Font.pretendard(.bold, size: 17))
                                            .padding(.leading, 26)
                                            .foregroundStyle(.black)
                                        
                                        Image("rightChevron2")
                                    }
                                }
                            }
                            
                            Spacer()
                        
                        }
                        .frame(width: screenWidth, height: 120)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.lightGray)
                            
                        }
                        
                        if let myOotdList = myPageVM.memberProfile?.ootdList {
                            
                            LazyVGrid(columns: columns, spacing: 1) {
                                
                                ForEach(myOotdList.indices, id: \.self) { index in
                                    
                                    let epochTime = myOotdList[index].date
                                    
                                    let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
                                    
                                    let dateString = dateFormatter.string(from: date)
                                    
                                    OOTDComponent(date: dateString, minTemp: myOotdList[index].lowestTemp, maxTemp: myOotdList[index].highestTemp, ootdImageURL: myOotdList[index].imageURL) {
                                    }
                                    .frame(width: screenWidth/2)
                                    .onAppear {
                                        
                                        if index == myOotdList.count - 1 {
                                            Task {
                                                await myPageVM.pagingMyProfileOOTD()
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                        } else {
                            
                            VStack {
                                Text("조회된 OOTD가 없어요")
                                    .font(Font.pretendard(.bold, size: 15))
                                
                                Image("noOOTDList")
                            }
                            .padding(.top, 150)
                        }
                    }
  
                }
                .refreshable {
                    Task {
                        await myPageVM.readMyProfile()
                    }
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MyPageMainView()
}
