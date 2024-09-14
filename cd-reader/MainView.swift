//
//  MainView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/29/24.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelection = 0
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ReaderView()
                .tabItem {
                    Label("Reader", systemImage: "barcode.viewfinder")
                }
                .tag(0)

            StorageView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Storage", systemImage: "folder")
                }
                .tag(1)
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .inactive { saveAction() }
        }
    }
}
