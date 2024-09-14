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
                    ForEach(self.storedItems.getItems(), id: \.self) { code in
                        NavigationLink(value: code){
                            Text(code.getValue())
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
                    Spacer()
                }
                .navigationTitle(code.getValue())
            }
        }
    }
}

#Preview {
    
}
