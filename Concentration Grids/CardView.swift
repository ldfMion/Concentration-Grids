//
//  CardView.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 09/05/24.
//

import SwiftUI

struct CardView: View {
    let number: Int
    var hidden: Bool
    var clicked: Bool
    var color: Color
    var handleClick: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    var textColor: Color {
        clicked || colorScheme == .dark ? .customText : .white
    }
    var body: some View {
        Button(action: handleClick) {
            Text(String(format: "%02d", number))
                .font(.system(size: 300))  // 1
                .minimumScaleFactor(0.01)  // 2
                .lineLimit(1)  // 3
                .bold()
                .foregroundStyle(textColor)
                .opacity(hidden ? 0 : 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(color.opacity(clicked ? 0 : 1))
                .cornerRadius(10)
                .shadow(color: color.opacity(clicked ? 0 : 0.3), radius: 20)
        }
        //.disabled(!isNext)
    }
}

#Preview {
    CardView(number: 5, hidden: false, clicked: false, color: .customAccentRed){
    }
}
