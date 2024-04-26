//
//  FollowingListView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI
import Kingfisher

struct FollowingListView: View {
    
    @State var searchText: String = ""
    
    @StateObject var followingVM: FollowingViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            SearchBarComponent(searchText: $searchText, placeHolder: "닉네임을 검색하세요") { _ in
            }
            .padding(.horizontal, 18)
            .padding(.top, 5)
            
            Rectangle()
                .frame(width: screenWidth, height: 1)
                .foregroundStyle(Color(hex: 0xEDEEFA))
                .padding(.top, 15)
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
            
                    if followingVM.followingList == [] {
                        
                    } else {
                        
                        let followingList = followingVM.followingList
                        
                        ForEach(followingList.indices, id: \.self) { index in
                            
                            HStack(spacing: 0) {
                                
                                if let imageURL = followingList[index].imageURL, let url = URL(string: imageURL) {
                                    
                                    KFImage(url)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle().stroke(.main, lineWidth: 0.5)
                                        }
                                        
                                        
                                    
                                } else {
                                    Image("basicProfileIcon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle().stroke(.main, lineWidth: 0.5)
                                        }
                                        
                                }
                                
                                Text(followingList[index].nickname)
                                    .font(Font.pretendard(.medium, size: 15))
                                    .padding(.leading ,16)
                                
                                Spacer()
                                
                                FollowingBtnComponent(isFollowing: $followingVM.followingList[index].isFollowing)
                                
                            }
                            .padding(.vertical, 13)
                            .padding(.horizontal, 24)
                            .onAppear {
                                
                                if index == followingList.count - 1{
                                    Task {
                                        await followingVM.readFollowingList()
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 45)
            .refreshable {
                Task {
                    await followingVM.readFollowingList()
                }
            }
        }
        .navigationTitle("팔로잉한 계정")
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
    FollowingListView(followingVM: FollowingViewModel())
}
