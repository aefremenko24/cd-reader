//
//  ContentView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 5/31/24.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @EnvironmentObject private var storedItems: StoredItems
    
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a barcode to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr, .upce, .ean8, .ean13],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(scannedCode)
            
            Button("Scan barcode") {
                self.isPresentingScanner = true
            }
            
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
    }
}

#Preview {
    ContentView()
}
