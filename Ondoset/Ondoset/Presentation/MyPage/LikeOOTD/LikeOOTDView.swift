//
//  LikeOOTDView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/25/24.
//

import SwiftUI

struct LikeOOTDView: View {
    
    @StateObject var likeOOTDVM: LikeOOTDViewModel = .init()
    
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(screenWidth/2), spacing: 1), count: 2)
    
    private let dateFormatter = DateFormatter()
    
    init() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            if likeOOTDVM.ootdList == [] {
                
            } else {
                LazyVGrid(columns: columns, spacing: 1) {
                    
                    let ootdList = likeOOTDVM.ootdList
                    
                    ForEach(ootdList.indices, id: \.self) { index in
                        
                        let epochTime = ootdList[index].date
                        
                        let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
                        
                        let dateString = dateFormatter.string(from: date)
                        
                        OOTDComponent(date: dateString, minTemp: ootdList[index].lowestTemp, maxTemp: ootdList[index].highestTemp, ootdImageURL: ootdList[index].imageURL) {
                            
                            // OOTD 개별 조회 API
                            print("dateString: \(dateString)=====================")
                            
                        }
                        .frame(width: screenWidth/2)
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
        .refreshable {
            Task {
                await likeOOTDVM.readLikeOOTDList()
            }
        }
        .padding(.bottom, 50)
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
