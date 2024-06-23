//
//  GridDimensions.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 15/05/24.
//

import Foundation

struct GridDimensions: Equatable, Codable {
    var rows: Int
    var columns: Int
    init(_ rows: Int, _ columns: Int) {
        self.rows = rows
        self.columns = columns
    }
}
