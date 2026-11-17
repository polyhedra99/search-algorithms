//
//  Pinwheel4x4.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/20/26.
//

import PuzzleDomain

public enum Pinwheel4x4: Nibble16Ruleset {
    public enum Move: CaseIterable, PinwheelMove, Sendable {
        case left0, right0
        case left1, right1
        case left2, right2
        case left3, right3
        case left4, right4
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 4,
        columnCount: 4
    )
}

public extension Pinwheel4x4.Move {
    var anchorCell: Int {
        return switch self {
        case .left0, .right0: 5
        case .left1, .right1: 0
        case .left2, .right2: 2
        case .left3, .right3: 8
        case .left4, .right4: 10
        }
    }
    
    var isClockwise: Bool {
        return switch self {
        case .left0, .left1, .left2, .left3, .left4: false
        case .right0, .right1, .right2, .right3, .right4: true
        }
    }
}
