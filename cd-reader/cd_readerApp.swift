//
//  cd_readerApp.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 5/31/24.
//

import SwiftUI

@main
struct cd_readerApp: App {
    @StateObject private var storedItems = StoredItems()
    
    var body: some Scene {
        WindowGroup {
            MainView() {
                Task {
                    do {
                        try await storedItems.save(storedCodes: storedItems.storedCodes)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(self.storedItems)
            .task {
                do {
                    try await storedItems.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
}
