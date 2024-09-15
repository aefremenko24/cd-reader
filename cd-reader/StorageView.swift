//
//  StorageView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/29/24.
//

import SwiftUI
import CodeScanner
import SceneKit

struct StorageView: View {
    @EnvironmentObject var storedItems: StoredItems
    @Binding var tabSelection: Int
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Your Barcodes") {
                    Button("Add Barcode") {
                        tabSelection = 0
                    }
                    ForEach(self.storedItems.storedCodes, id: \.self) { code in
                        NavigationLink(value: code){
                            Text(code.value)
                        }
                    }
                    .onDelete(perform: storedItems.removeItem)
                }
            }
            .navigationTitle("Storage")
            .navigationDestination(for: Code.self) { code in
                VStack {
                    SceneView(scene: SCNScene(named: "3DModel.scn"),
                              options: .allowsCameraControl)
                    .frame(width: 400, height: 300)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 4)
                    )
                    HStack {
                        Button {}
                        label: {
                            VStack {
                                Image(systemName: "barcode")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(15)
                                Text("Barcode #").bold()
                                Text(code.value)
                            }
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                            .frame(width: 175, height: 175)
                            .shadow(radius: 5)
                            .padding(5)
                        }
                        
                        Button {}
                        label: {
                            VStack {
                                Image(systemName: "triangleshape")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(15)
                                Text("Object Type").bold()
                                Text(code.objectType)
                            }
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                            .frame(width: 175, height: 175)
                            .shadow(radius: 5)
                            .padding(5)
                        }
                    }
                    HStack {
                        Button{}
                        label: {
                            VStack {
                                Image(systemName: "paintpalette")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(15)
                                Text("Color").bold()
                                Text(code.color)
                            }
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                            .frame(width: 175, height: 175)
                            .shadow(radius: 5)
                            .padding(5)
                        }
                        
                        let formatter = DateFormatter()
                        let _ = formatter.dateStyle = .short
                        Button {}
                        label: {
                            VStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(15)
                                Text("Date Added").bold()
                                Text(formatter.string(from: code.dateAdded))
                            }
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                            .frame(width: 175, height: 175)
                            .shadow(radius: 5)
                            .padding(5)
                        }
                    }
                    Spacer()
                }
                .navigationTitle(code.value)
            }
        }
    }
}

#Preview {
    StorageView(tabSelection: .constant(0))
        .environmentObject(StoredItems())
}
