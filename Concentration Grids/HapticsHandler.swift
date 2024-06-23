//
//  HapticsHandler.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 16/05/24.
//

import Foundation
import SwiftUI

class HapticsHandler {
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var selectionGenerator = UISelectionFeedbackGenerator()
    init() {
        self.prepare()
    }
    func prepare() {
        notificationGenerator.prepare()
        selectionGenerator.prepare()
    }
    func gameFinished() {
        notificationGenerator.notificationOccurred(.success)
    }
    func wrongCard() {
        notificationGenerator.notificationOccurred(.warning)
    }
    func correctCard() {
        selectionGenerator.selectionChanged()
    }
}
