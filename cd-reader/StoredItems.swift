//
//  Storage.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/30/24.
//

import Foundation

class StoredItems: ObservableObject {
    @Published var storedCodes = [String]()
    
    func addToStorage(code: String) {
        self.storedCodes.append(code)
    }
    
    func getItems() -> [String] {
        return storedCodes
    }
}
