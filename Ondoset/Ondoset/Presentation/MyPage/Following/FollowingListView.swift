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
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            
            SearchBarComponent(searchText: $searchText, placeHolder: "닉네임을 검색하세요", searchAction: { text in
                
                Task {
                    
                    
                    await followingVM.searchFollowingList(search: text)
                }
            })
            .padding(.horizontal, 18)
            .padding(.top, 5)
            .onChange(of: searchText) { _ in
                
                followingVM.searchLastPage = -1
                
            }
            
            Rectangle()
                .frame(width: screenWidth, height: 1)
                .foregroundStyle(Color(hex: 0xEDEEFA))
                .padding(.top, 15)
            
            
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
            
                    if followingVM.followingList == [] {
                        
                        BlankDataIndicateComponent(explainText: "아직 팔로우한 계정이 없어요 \n다른 계정을 팔로우하고 언제든 다시 찾아보세요")
                            .offset(y: 200)
                        
                    } else {
                        
//                        let followingList = followingVM.followingList
                        
                        ForEach(followingVM.followingList.indices, id: \.self) { index in
                            
                            HStack(spacing: 0) {
                                
                                if let imageURL = followingVM.followingList[index].imageURL, let url = URL(string: imageURL) {
                                    
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
                                
                                NavigationLink(destination: OtherProfileView(nickname: followingVM.followingList[index].nickname ?? "테스트 타인 닉네임", profileImage: followingVM.followingList[index].imageURL, memberId: followingVM.followingList[index].memberId ?? 0, isFollowing: followingVM.followingList[index].isFollowing, ootdCount: followingVM.followingList[index].ootdCount ?? 0)) {
                                    
                                    Text(followingVM.followingList[index].nickname)
                                        .font(Font.pretendard(.medium, size: 15))
                                        .padding(.leading ,16)
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                
                                FollowingBtnComponent(isFollowing: $followingVM.followingList[index].isFollowing) {
                                    
                                    if followingVM.followingList[index].isFollowing {
                                        
                                        Task {
                                            print("팔로잉 여부: :\(followingVM.followingList[index].isFollowing)")
                                            
                                            await followingVM.cancelFollowOther(index: index)
                                        }
                                        
                                    } else {
                                        Task {

                                            await followingVM.followOther(index: index)
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.vertical, 13)
                            .padding(.horizontal, 24)
                            .onAppear {
                                
                                if index == followingVM.followingList.count - 1{
                                    Task {
                                        await followingVM.readFollowingList()
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            .refreshable {
                Task {
                    await followingVM.readFollowingList()
                }
            }
        }
        .onAppear {
            wholeVM.isTabBarHidden = true
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
