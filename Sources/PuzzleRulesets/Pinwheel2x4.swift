//
//  Pinwheel2x4.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public enum Pinwheel2x4: Nibble16Ruleset {
    public enum Move: CaseIterable, PinwheelMove, Sendable {
        case left0, right0
        case left1, right1
        case left2, right2
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 2,
        columnCount: 4
    )
}

public extension Pinwheel2x4.Move {
    var anchorCell: Int {
        return switch self {
        case .left0, .right0: 1
        case .left1, .right1: 0
        case .left2, .right2: 2
        }
    }
    
    var isClockwise: Bool {
        return switch self {
        case .left0, .left1, .left2: false
        case .right0, .right1, .right2: true
        }
    }
}
