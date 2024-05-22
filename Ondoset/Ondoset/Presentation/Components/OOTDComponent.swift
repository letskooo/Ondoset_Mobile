//
//  PostComponent.swift
//  Ondoset
//
//  Created by KoSungmin on 4/24/24.
//

import SwiftUI
import Kingfisher

struct OOTDComponent: View {
    
    let date: String
    let minTemp: Int?
    let maxTemp: Int?
    
    let ootdImageURL: String
    
    var body: some View {
        
        KFImage(URL(string: ootdImageURL))
            .resizable()
            .aspectRatio(9/16, contentMode: .fit)
            .overlay {
                VStack {

                    HStack {

                        Text(date)
                            .padding(.leading, 20)
                            .font(Font.pretendard(.semibold, size: 12))
                            .foregroundStyle(.black)

                        Spacer()

                        if let minTemp = minTemp, let maxTemp = maxTemp {

                            HStack {
                                Text("\(minTemp)°C")
                                    .foregroundStyle(.blue)
                                    .font(Font.pretendard(.bold, size: 11))

                                Text("/")
                                    .font(Font.pretendard(.bold, size: 11))

                                Text("\(maxTemp)°C")
                                    .foregroundStyle(.red)
                                    .font(Font.pretendard(.bold, size: 11))
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    .padding(.top, 3)
                    .padding(.bottom, 3)
                    .background(Color(hex: 0xFFFFFF)).opacity(0.8)

                    Spacer()

                }
                .padding(.top, 20)
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
//                ImageCache.default.clearMemoryCache()
//                ImageCache.default.clearDiskCache()
            }
        
//        Image("testImage3")
//            .resizable()
//            .aspectRatio(9/16, contentMode: .fit)
//            .overlay {
//                
//                VStack {
//                    
//                    HStack {
//                        
//                        Text(date)
//                            .padding(.leading, 20)
//                            .font(Font.pretendard(.semibold, size: 18))
//                        
//                        Spacer()
//                        
//                        if let minTemp = minTemp, let maxTemp = maxTemp {
//                            
//                            HStack {
//                                Text("\(minTemp)°C")
//                                    .foregroundStyle(.blue)
//                                    .font(Font.pretendard(.semibold, size: 18))
//                                
//                                Text("/")
//                                    .font(Font.pretendard(.semibold, size: 18))
//                                
//                                Text("\(maxTemp)°C")
//                                    .foregroundStyle(.red)
//                                    .font(Font.pretendard(.semibold, size: 18))
//                            }
//                            .padding(.trailing, 20)
//                        }
//                    }
//                    .padding(.top, 10)
//                    .padding(.bottom, 10)
//                    .background(Color(hex: 0xFFFFFF)).opacity(0.8)
//                    
//                    Spacer()
//                    
//                }
//                .padding(.top, 20)
//            }
//            .edgesIgnoringSafeArea(.all)
//            .onTapGesture {
//                action()
//            }
    }
}

#Preview {
    OOTDComponent(date: "2024.3.16", minTemp: 4, maxTemp: 15, ootdImageURL: "Hello")
}
