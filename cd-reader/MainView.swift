//
//  MainView.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/29/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ReaderView()
                .tabItem {
                    Label("Reader", systemImage: "barcode.viewfinder")
                }

            StorageView()
                .tabItem {
                    Label("Storage", systemImage: "folder")
                }
        }
    }
}

#Preview {
    MainView()
}
