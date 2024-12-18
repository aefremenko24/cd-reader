//
//  Storage.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 8/30/24.
//

import Foundation

@MainActor
class StoredItems: ObservableObject, Codable {
    @Published var storedCodes: [Code] = [Code(value: "1234567890")]
    
    func addToStorage(code: Code) {
        self.storedCodes.append(code)
    }
    
    func removeItem(at: IndexSet) {
        self.storedCodes.remove(atOffsets: at)
    }
    
    func contains(code: Code) -> Bool {
        var doesContain = false
        
        for currentCode in self.storedCodes {
            if currentCode.value == code.value {
                doesContain = true
            }
        }
        
        return doesContain
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("cdreader.data")
    }
    
    func load() async throws {
        let task = Task<[Code], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let storedCodes = try JSONDecoder().decode([Code].self, from: data)
            return storedCodes
        }
        let storedCodes = try await task.value
        self.storedCodes = storedCodes
    }
    
    func save(storedCodes: [Code]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(storedCodes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    enum CodingKeys: CodingKey {
        case storedCodes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(storedCodes, forKey: .storedCodes)
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        storedCodes = try container.decode([Code].self, forKey: .storedCodes)
    }
}

struct Code: Hashable, Codable {
    public var value: String
    public var objectType: String
    public var color: String
    public var dateAdded: Date
    
    init(value: String) {
        self.value = value
        self.objectType = "None"
        self.color = "None"
        self.dateAdded = Date()
    }
}
