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
    @State private var showingAlert = false
    
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
                        @State var value = code.value
                        Button {
                            showingAlert = true
                        }
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
                        .alert("Change the barcode value", isPresented: $showingAlert) {
                            TextField("New Value:", text: $value)
                            Button("Save") {
                                code.value = value
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                        
                        @State var objectType = code.objectType
                        Button {
                            showingAlert = true
                        }
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
                        .alert("Change the barcode object type", isPresented: $showingAlert) {
                            TextField("New Object Type:", text: $objectType)
                            Button("Save") {
                                code.objectType = objectType
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                    }
                    HStack {
                        @State var objectColor = code.color
                        Button{
                            showingAlert = true
                        }
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
                        .alert("Change the color of the 3D object", isPresented: $showingAlert) {
                            TextField("New Object Color:", text: $objectColor)
                            Button("Save") {
                                code.color = objectColor
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                        
                        let formatter = DateFormatter()
                        let _ = formatter.dateStyle = .short
                        Button {
                            showingAlert = true
                        }
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
                        .alert("This is the date the barcode was added", isPresented: $showingAlert) {
                            Text("The date cannot be changed.")
                            Button("Cancel", role: .cancel) { }
                        }
                    }
                    Spacer()
                }
                .navigationTitle(code.value)
            }
        }
    }
    
    func changeTextField(boxName: String, boxText: String, value: String) -> String {
        var inputValue: String?
        
        let alertController = UIAlertController(title: "Barcode Value", message: "Enter a value for this barcode", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = value
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            let input = alertController.textFields![0].text
            inputValue = input

        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        return inputValue!
    }
}

#Preview {
    StorageView(tabSelection: .constant(0))
        .environmentObject(StoredItems())
}
