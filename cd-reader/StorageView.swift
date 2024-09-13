//
//  StorageView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/29/24.
//

import SwiftUI
import CodeScanner

struct StorageView: View {
    @EnvironmentObject var storedItems: StoredItems
    
    var body: some View {
        NavigationStack {
            List {
                Section("Your Barcodes") {
                    Button("Add Barcode") {
                        ReaderView()
                    }
                    ForEach(self.storedItems.getItems(), id: \.self) { code in
                        NavigationLink(value: code){
                            Text(code.getValue())
                        }
                    }
                    .onDelete { storedItems.removeItem(at: $0 == code)
                    }
                }
            }
            .navigationTitle("Storage")
            .navigationDestination(for: Code.self) { code in
                ZStack {
                    Text(code.getValue())
                }
            }
        }
    }
}

#Preview {
    StorageView()
}
