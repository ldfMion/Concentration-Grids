//
//  ContentView.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 08/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var store = AttemptStore()
    @StateObject private var g = CGGame()
    @State private var colorTheme: Color = .customAccentBlue
    
    @State private var centiseconds = 0
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    
    private var feedback = HapticsHandler()
    
    func handleCardTap(of cardNumber: Int) {
        print("card tapped")    
        g.handleCardTap(cardNumber: cardNumber, feedback: feedback) {
            store.add(Attempt(dimensions: g.dimensions, time: centiseconds))
        }
    }
    
    var body: some View {
            NavigationStack {
                VStack {
                    TimerView(centiseconds: centiseconds)
                    CardGrid(dimensions: g.dimensions, numbers: g.numbers, color: colorTheme, handleClick: handleCardTap, nextCard: g.nextNumber)
                }
                .padding()
                .toolbar {
                    HStack {
                        Button(action: g.restart) {
                            Image(systemName: "arrow.clockwise")
                                .bold()
                        }
                        Button(action: g.showSettings) {
                            Image(systemName: "gear")
                                .bold()
                        }
                    }
                }
                
            }
            .sheet(isPresented: $g.showingSettings) {
                Settings(
                    dimensions: $g.dimensions,
                    attemptsStore: store,
                    color: $colorTheme
                )
            }
            .onChange(of: g.dimensions, g.restart)
            .onReceive(timer) { input in
                updateTimer()
            }
            .onChange(of: scenePhase){ _ , newPhase in
                handleAppClose(newPhase: newPhase)
            }
            .foregroundColor(Color("customText"))
    }
    
    private func updateTimer() {
            if(g.status == .active){
                centiseconds += 1
                return
            }
            if(g.status == .notStarted){
                centiseconds = 0
            }
    }
    private func handleAppClose(newPhase: ScenePhase) {
        if newPhase == .active {
            if(g.status == .paused) {
                g.start()
            }
        } else {
            if(g.status == .active) {
                g.pause()
            }
        }
    }
}

#Preview {
    ContentView()
}
