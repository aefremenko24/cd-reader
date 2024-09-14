//
//  ReaderView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 5/31/24.
//

import SwiftUI
import CodeScanner

struct ReaderView: View {
    @EnvironmentObject var storedItems: StoredItems
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a barcode to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.upce, .ean8, .ean13],
            completion: { result in
                if case let .success(code) = result {
                    
                    let newCode = Code(value: code.string, object: "None", color: "None")
                    
                    if (storedItems.contains(code: newCode)) {
                        self.scannedCode = newCode.getValue() + " is already in the storage"
                    }
                    else {
                        self.scannedCode = newCode.getValue() + " has been added to the storage"
                        self.storedItems.addToStorage(code: newCode)
                    }
                    self.isPresentingScanner = false
                    self.storedItems.addToStorage(code: Code(value: "1234567890", object: "None", color: "None"))
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(scannedCode)
            
            Button("Scan barcode", systemImage: "barcode.viewfinder") {
                self.isPresentingScanner = true
            }
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
    }
}

#Preview {
    ReaderView()
}
