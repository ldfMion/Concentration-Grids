//
//  CardGrid.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 09/05/24.
//

import SwiftUI

struct CardGrid: View {
    // "parameters"
    var dimensions: GridDimensions
    var numbers: [Int]
    var color: Color
    var handleClick: (Int) -> Void
    
    // computed fields
    var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: GRID_SPACING), count: dimensions.columns)
    }
    
    // constants
    let GRID_SPACING = 10.0
    
    // state variables
    var nextCard: Int

    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: gridColumns, spacing: GRID_SPACING) {
                ForEach(numbers, id: \.self) { number in
                    CardView(
                        number: number,
                        hidden: shouldHide(card: number),
                        clicked: wasClicked(card: number),
                        color: color
                    ){
                        handleClick(number)
                    }
                        .frame(height: calculateCardSize(gridSize: geometry.size.height))
                }
            }
        }
    }
    
    // methods
    func calculateCardSize(gridSize: Double) -> Double {
        let heightWithoutSpacing = gridSize - GRID_SPACING * Double(dimensions.rows - 1)
        let cardHeight = heightWithoutSpacing/Double(dimensions.rows)
        return cardHeight
    }
    func shouldHide(card number: Int) -> Bool {
        return nextCard == 0 && number != nextCard
    }
    func wasClicked(card number: Int) -> Bool {
        return nextCard > number
    }
}


#Preview {
    let rows = 12
    let columns = 5
    let numbers = Array(STARTING_CARD..<rows*columns).shuffled()
    func a(card: Int) {}
    return CardGrid(dimensions: GridDimensions(rows,columns), numbers: numbers, color: Color.customAccentBlue, handleClick: a, nextCard: 0)
}
