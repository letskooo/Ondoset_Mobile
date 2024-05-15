//
//  OtherProfileView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/15/24.
//

import SwiftUI
import Kingfisher

struct OtherProfileView: View {
    
    // 타인 닉네임
    @State var nickname: String = ""
    
    // 타인 프로필 이미지
    @State var profileImage: String?
    
    // 타인 멤버 아이디
    @State var memberId: Int = 0
    
    // 팔로잉 여부
    @State var isFollowing: Bool = false
    
    @State var ootdCount: Int = 0
    
    @StateObject var otherProfileVM: OtherProfileViewModel = .init()
    
    let myMemberId = UserDefaults.standard.integer(forKey: "memberId")
    
//    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        VStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    HStack {
                        
                        if let profileImage = profileImage, let url = URL(string: profileImage) {
                            
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
                            
                            Image("basicProfileIcon")
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
                        
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HStack(spacing: 20) {
                                
                                Text("게시한 OOTD")
                                    .font(Font.pretendard(.regular, size: 15))
                                
                                Text("\(ootdCount)")
                                    .font(Font.pretendard(.bold, size: 17))
                                
                            }
                            
                            if myMemberId != memberId {
                                
                                FollowingBtnComponent(isFollowing: $otherProfileVM.isFollowing, action: {
                                    
                                    if otherProfileVM.isFollowing {
                                        
                                        Task {
                                            await otherProfileVM.cancelFollowOther(memberId: memberId)
                                        }
                                        
                                    } else {
                                        
                                        Task {
                                            await otherProfileVM.followOther(memberId: memberId)
                                        }
                                    }
                                })
                            }
                                
                            
                        }
                        .offset(x: -20)
                        
                        Spacer()
                        
                    }
                    .frame(width: screenWidth, height: 120)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightGray)
                        
                    }
                    
                    if otherProfileVM.ootdList != [] {
                        
                        LazyVGrid(columns: Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2), spacing: 1) {
                            
                            ForEach(otherProfileVM.ootdList.indices, id: \.self) { index in
                                
                                let dateString = DateFormatter.string(epoch: otherProfileVM.ootdList[index].date)
                                
                                NavigationLink(destination: OOTDItemView(ootdId: otherProfileVM.ootdList[index].ootdId, ootdImageURL: otherProfileVM.ootdList[index].imageURL, dateString: dateString, lowestTemp: otherProfileVM.ootdList[index].lowestTemp, highestTemp: otherProfileVM.ootdList[index].highestTemp)) {
                                    
                                    OOTDComponent(date: dateString, minTemp: otherProfileVM.ootdList[index].lowestTemp, maxTemp: otherProfileVM.ootdList[index].highestTemp, ootdImageURL: otherProfileVM.ootdList[index].imageURL)
                                    
                                }
                                .onAppear {
                                    if index == otherProfileVM.ootdList.count - 1 {
                                        Task {
                                            await otherProfileVM.getOtherProfile(memberId: memberId)
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle(nickname)
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
        .onAppear {
            
            Task {
                
                await otherProfileVM.getOtherProfile(memberId: memberId)
                
                otherProfileVM.isFollowing = isFollowing
                
            }
            
        }
        
    }
}

#Preview {
    OtherProfileView()
}
