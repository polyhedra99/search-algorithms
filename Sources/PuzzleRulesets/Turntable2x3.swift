//
//  Turntable2x3.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public enum Turntable2x3: Nibble16Ruleset {
    public enum Move: CaseIterable, TurntableMove, Sendable {
        case left0, right0
        case left1, right1
        case left2, right2
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 2,
        columnCount: 3
    )
}

public extension Turntable2x3.Move {
    var displacement: TurntableDisplacement {
        return switch self {
        case .left0, .right0:
            .ring(right: 0, down: 0x000F, left: 0, up: 0xF000)
        case .left1:
            .linear(mask: 0x000FFF, wrap: 8, linear: 4)
        case .right1:
            .linear(mask: 0x000FFF, wrap: 4, linear: 8)
        case .left2:
            .linear(mask: 0xFFF000, wrap: 8, linear: 4)
        case .right2:
            .linear(mask: 0xFFF000, wrap: 4, linear: 8)
        }
    }
}
