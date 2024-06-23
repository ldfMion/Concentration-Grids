//
//  AttemptHistory.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 13/05/24.
//
import Foundation
import SwiftUI

struct AttemptHistory: View {
    var attemptStore: AttemptStore
    var attempts: [Attempt] {
        attemptStore.getAttempts()
    }
    var attemptsByDate: [Date: [Attempt]] {
        return Dictionary(grouping: attempts, by: {$0.date.stripTime()})
    }
    var days: [Date] {
        return attemptsByDate.map({ $0.key }).sorted().reversed()
    }
    var body: some View {
        NavigationStack {
            if(attempts.isEmpty){
                Text("No attempts to show yet.")
            } else {
                List(days, id: \.self) { day in
                    Section(header: Text(day.asRelativeNamed())){
                        ForEach(attemptsByDate[day]!.sorted(by: {$0.date.compare($1.date) == .orderedDescending}), id: \.date){attempt in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(formatCentiseconds(attempt.time))
                                        .font(.title2)
                                        .bold()
                                    Text("\(attempt.dimensions.rows) x \(attempt.dimensions.columns)")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(attempt.date.formatted(date: .omitted, time: .shortened))
                                    .bold()
                            }
                        }
                        .onDelete(perform: attemptStore.remove)
                    }
                }
                .navigationTitle("Attempt History")
            }
        }
    }
}

#Preview {
    let store = AttemptStore()
    let grid = GridDimensions(1, 1)
    let attempt1 = Attempt(dimensions: grid, time: 100)
    store.add(attempt1)
    let attempt2 = Attempt(dimensions: GridDimensions(5,5), time: 1000)
    store.add(attempt2)
    let attemp3 = Attempt(dimensions: GridDimensions(1, 2), time: 10000)
    store.add(attemp3)
    /*
    attempts[1].date = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
    attempts[2].date = Calendar.current.date(byAdding: .hour, value: -1, to: Date.now)!
    for attempt in attempts {
        store.add(attempt)
    }*/
    return AttemptHistory(attemptStore: store)
}
