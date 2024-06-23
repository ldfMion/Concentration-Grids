//
//  StorageManager.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 16/05/24.
//

import Foundation

class StorageManager<T: Codable> {
    private var key: String
    init(key: String){
        self.key = key
    }
    func load() -> T? {
        if let savedValue = UserDefaults.standard.data(forKey: key) {
            if let decodedValue = try? JSONDecoder().decode(T.self, from: savedValue){
                return decodedValue
            }
        }
        return nil
    }
    func save(value: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
