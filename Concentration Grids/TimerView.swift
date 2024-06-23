//
//  TimerView.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 09/05/24.
//

import SwiftUI

struct TimerView: View {
    var centiseconds: Int
    var body: some View {
            Text("\(formatCentiseconds(centiseconds))")
                .font(.title2)
                .bold()
        }
}

#Preview {
    TimerView(centiseconds: 1000)
}
