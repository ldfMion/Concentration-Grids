//
//  CGGame.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 12/05/24.
//

import Foundation

let STARTING_CARD = 0
let GRID_SETTINGS_KEY = "gridSettings"

class CGGame: ObservableObject {
    @Published var dimensions: GridDimensions {
        didSet{
            dimensionsStorageManager.save(value: dimensions)
        }
    }
    @Published var showingSettings: Bool
    @Published var numbers: [Int]
    @Published var status: GameStatus
    @Published var nextNumber: Int
    private var dimensionsStorageManager: StorageManager<GridDimensions>
    init(){
        self.dimensionsStorageManager = StorageManager(key: GRID_SETTINGS_KEY)
        let dimensions = dimensionsStorageManager.load() ?? GridDimensions(5,5)
        self.dimensions = dimensions
        self.showingSettings = false
        self.status = .notStarted
        self.numbers = Self.generateNumbers(dimensions.rows, dimensions.columns)
        self.nextNumber = STARTING_CARD
    }
    func start(){
        status = .active
    }
    func stop(){
        status = .finished
    }
    func pause(){
        status = .paused
    }
    func restart(){
        status = .notStarted
        self.nextNumber = STARTING_CARD
        numbers = CGGame.generateNumbers(dimensions.rows, dimensions.columns)
    }
    func handleCardTap(cardNumber: Int, feedback: HapticsHandler, storeAttempt: () -> Void) {
        print("card tapped inner")
        if(!isCorrectCard(number: cardNumber)){
            feedback.wrongCard()
            return
        }
        if(nextCardIsFirst()){
            feedback.prepare()
            start()
        } else if(nextCardIsLast()){
            print("handling finished game")
            stop()
            storeAttempt()
            feedback.gameFinished()
        } else {
            feedback.correctCard()
        }
        nextNumber += 1
    }
    func showSettings(){
        showingSettings = true
    }
    // private methods
    private func nextCardIsFirst() -> Bool {
        return nextNumber == STARTING_CARD
    }
    private func nextCardIsLast() -> Bool {
        let lastCard = getNumberOfCards() - 1
        return lastCard == nextNumber
    }
    private func getNumberOfCards() -> Int {
        return dimensions.rows * dimensions.columns
    }
    private func isCorrectCard(number: Int) -> Bool {
        return number == nextNumber
    }
    // static methods
    static func generateNumbers(_ rows: Int, _ columns: Int) -> [Int] {
        return Array(0..<rows*columns).shuffled()
    }
}
