//
//  Settings.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 09/05/24.
//

import SwiftUI

let ROW_RANGE = 1...10
let COLUMN_RANGE = 1...6

struct Settings: View {
    @Binding var dimensions: GridDimensions
    var attemptsStore: AttemptStore
    @Binding var color: Color
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Grid")) {
                    Stepper("Rows: \(dimensions.rows)", value: $dimensions.rows, in: ROW_RANGE)
                    Stepper("Columns: \(dimensions.columns)", value: $dimensions.columns, in: COLUMN_RANGE)
                }
                Section(){
                    NavigationLink(){
                        AttemptHistory(attemptStore: attemptsStore)
                    } label: {
                        Label("Attempt History", systemImage: "list.bullet.rectangle")
                    }
                }
                Section() {
                    Picker("Color Theme:", selection: $color) {
                        Text("Red").tag(Color.customAccentRed)
                            
                        Text("Blue").tag(Color.customAccentBlue)
                            .foregroundColor(Color.customAccentBlue)
                    }
                    .foregroundColor(color)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    let dimensions = GridDimensions(5, 5)
    return Settings(dimensions: .constant(dimensions), attemptsStore: AttemptStore(), color: .constant(Color.customAccentBlue))
}
