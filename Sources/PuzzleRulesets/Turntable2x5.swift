//
//  Turntable2x5.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public enum Turntable2x5: Nibble16Ruleset {
    public enum Move: CaseIterable, TurntableMove, Sendable {
        case left0, right0
        case left1, right1
        case left2, right2
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 2,
        columnCount: 5
    )
}

public extension Turntable2x5.Move {
    var displacement: TurntableDisplacement {
        return switch self {
        case .left0:
            .ring(
                right: 0x00F0_0000,
                down: 0x0000_000F,
                left: 0x0000_00F0,
                up: 0x0F00_0000
            )
        case .right0:
            .ring(
                right: 0x0000_000F,
                down: 0x0000_00F0,
                left: 0x0F00_0000,
                up: 0x00F0_0000
            )
        case .left1:
            .linear(mask: 0x0000_000F_FFFF, wrap: 16, linear: 4)
        case .right1:
            .linear(mask: 0x0000_000F_FFFF, wrap: 4, linear: 16)
        case .left2:
            .linear(mask: 0x00FF_FFF0_0000, wrap: 16, linear: 4)
        case .right2:
            .linear(mask: 0x00FF_FFF0_0000, wrap: 4, linear: 16)
        }
    }
}
