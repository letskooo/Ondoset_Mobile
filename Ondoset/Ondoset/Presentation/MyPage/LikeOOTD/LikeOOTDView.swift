//
//  LikeOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct LikeOOTDView: View {
    
    @StateObject var likeOOTDVM: LikeOOTDViewModel = .init()
    @EnvironmentObject var wholeVM: WholeViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            if likeOOTDVM.ootdList == [] {
                
                BlankDataIndicateComponent(explainText: "공감한 OOTD가 없어요 \n다른 사용자의 OOTD에 공감하기를 눌러보세요")
                    .offset(y: 250)
                
            } else {
                LazyVGrid(columns: columns, spacing: 1) {
                    
                    let ootdList = likeOOTDVM.ootdList
                    
                    ForEach(ootdList.indices, id: \.self) { index in
                        
                        let dateString = DateFormatter.string(epoch: ootdList[index].date)
                        
                        NavigationLink(destination: OOTDItemView(ootdId: ootdList[index].ootdId, ootdImageURL: ootdList[index].imageURL, dateString: dateString, lowestTemp: ootdList[index].lowestTemp, highestTemp: ootdList[index].highestTemp)) {
                            OOTDComponent(date: dateString, minTemp: ootdList[index].lowestTemp, maxTemp: ootdList[index].highestTemp, ootdImageURL: ootdList[index].imageURL)
                            .frame(width: screenWidth / 2)
                        }
                        .onAppear {
                            
                            if index == ootdList.count - 1 {
                                Task {
                                    await likeOOTDVM.readLikeOOTDList()
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            wholeVM.isTabBarHidden = true
        }
        .refreshable {
            Task {
                await likeOOTDVM.readLikeOOTDList()
            }
        }
        .navigationTitle("공감한 OOTD")
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
    LikeOOTDView()
}
