//
//  Storage.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/30/24.
//

import Foundation

class StoredItems: ObservableObject {
    @Published var storedCodes = [Code]()
    
    func addToStorage(code: Code) {
        self.storedCodes.append(code)
    }
    
    func getItems() -> [Code] {
        return storedCodes
    }
    
    func removeItem(at: Int) {
        if (storedCodes.count > at) {
            self.storedCodes.remove(at: at)
        }
    }
    
    func contains(code: Code) -> Bool {
        var doesContain = false
        
        for currentCode in self.storedCodes {
            if currentCode.getValue() == code.getValue() {
                doesContain = true
            }
        }
        
        return doesContain
    }
}

struct Code: Hashable {
    let value: String
    let object: String
    let color: String
    
    func getValue() -> String {
        return self.value
    }
    
    func getObject() -> String {
        return self.object
    }
    
    func getColor() -> String {
        return self.color
    }
}
