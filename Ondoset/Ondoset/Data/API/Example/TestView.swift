//
//  TestView.swift
//  Ondoset
//
//  Created by KoSungmin on 4/9/24.
//

//import SwiftUI
//
//struct TestView: View {
//    
//    @StateObject var testVM: TestViewModel = .init()
//    
//    var body: some View {
//        
//        VStack {
//            Button {
//                Task {
//                    await testVM.testRequestPlain()
//                }
//            } label: {
//                Text("testRequestPlain")
//            }
//            
//            Text(testVM.plainName)
//            
//            Divider()
//            
//            Button {
//                Task {
//                    await testVM.testRequestJSON()
//                }
//            } label: {
//                Text("testRequestJSON")
//            }
//            Text(testVM.jsonName)
//            
//            Divider()
//            
//            Button {
//                Task {
//                    await testVM.testRequestQueryParams()
//                }
//            } label: {
//                Text("testRequestQueryParams")
//            }
//            Text(testVM.queryParamName)
//            
//            Divider()
//            
//            Button {
//                Task {
//                    await testVM.testRequestPathVariable()
//                }
//            } label: {
//                Text("testRequestPathVaraible")
//            }
//            Text(testVM.pathVariableName)
//        }
//    }
//}
//
//#Preview {
//    TestView()
//}
