//
//  AttemptStore.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 13/05/24.
//

import Foundation

let ATTEMPTS_KEY = "attemptHistory"

class AttemptStore: ObservableObject {
    private var attempts: [Attempt]
    private var storageManager = StorageManager<[Attempt]>(key: ATTEMPTS_KEY)
    init() {
        // fix with dependency injection
        self.attempts = storageManager.load() ?? []
    }
    func add(_ attempt: Attempt){
        attempts.append(attempt)
        publishUpdates()
        save()
        print("added attempt \(attempt)")
    }
    func remove(at offsets: IndexSet) {
        attempts.remove(atOffsets: offsets)
        publishUpdates()
        save()
    }
    func getAttempts() -> [Attempt]{
        return attempts;
    }
    private func save(){
        storageManager.save(value: attempts)
    }
    private func publishUpdates() {
        print("should have updated")
        objectWillChange.send()
    }
}

struct Attempt: Codable {
    var dimensions: GridDimensions
    var time: Int
    var date: Date
    init(dimensions: GridDimensions, time: Int) {
        self.dimensions = dimensions
        self.time = time
        self.date = Date.now
    }
}
