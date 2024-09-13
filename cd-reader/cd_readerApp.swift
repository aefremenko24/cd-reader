//
//  cd_readerApp.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 5/31/24.
//

import SwiftUI

@main
struct cd_readerApp: App {
    @StateObject var storedItems = StoredItems()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(self.storedItems)
        }
    }
    
}
