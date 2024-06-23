//
//  FormatCentiseconds.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 15/05/24.
//

import Foundation

func formatCentiseconds(_ centiseconds: Int) -> String {
    let minutes = centiseconds / 100 / 60
    let seconds = centiseconds / 100 % 60
    let centiseconds = centiseconds % 100
    return String(format: "%02d:%02d:%02d", minutes, seconds,centiseconds)
}
