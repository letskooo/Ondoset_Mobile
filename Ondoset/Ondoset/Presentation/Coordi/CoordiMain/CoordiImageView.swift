//
//  CooriImageView.swift
//  Ondoset
//
//  Created by KoSungmin on 5/7/24.
//

import SwiftUI
import Kingfisher

struct CoordiImageView: View {
    
    @Binding var openPhoto: Bool
    var coordiRecord: CoordiRecord
    
    var body: some View {
        
        VStack(spacing: 0) {
            if let imageURL = coordiRecord.imageURL {

                KFImage(URL(string: imageURL))
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .onAppear {
                        print("imageURL: \(imageURL)")
                    }
                    .cornerRadius(10)

            } else {

                Image("unselectedImage")
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .offset(x: 3, y: 3)
            }
        }
        .onTapGesture {
            openPhoto.toggle()
        }
        
    }
}

//#Preview {
//    CooriImageView(coordiRecord: .constant(CoordiRec))
//}
