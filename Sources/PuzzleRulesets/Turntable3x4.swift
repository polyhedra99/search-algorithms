//
//  Turntable3x4.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public enum Turntable3x4: Nibble16Ruleset {
    public enum Move: CaseIterable, TurntableMove, Sendable {
        case left0, right0
        case left1, right1
        case left2, right2
        case left3, right3
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 3,
        columnCount: 4
    )
}

public extension Turntable3x4.Move {
    var displacement: TurntableDisplacement {
        return switch self {
        case .left0:
            .ring(
                right: 0x000F_0000_0000,
                down: 0x0000_000F_000F,
                left: 0x0000_0000_00F0,
                up: 0x00F0_00F0_0000
            )
        case .right0:
            .ring(
                right: 0x0000_0000_000F,
                down: 0x0000_00F0_00F0,
                left: 0x00F0_0000_0000,
                up: 0x000F_000F_0000
            )
        case .left1:
            .linear(mask: 0x0000_0000_FFFF, wrap: 12, linear: 4)
        case .right1:
            .linear(mask: 0x0000_0000_FFFF, wrap: 4, linear: 12)
        case .left2:
            .linear(mask: 0x0000_FFFF_0000, wrap: 12, linear: 4)
        case .right2:
            .linear(mask: 0x0000_FFFF_0000, wrap: 4, linear: 12)
        case .left3:
            .linear(mask: 0xFFFF_0000_0000, wrap: 12, linear: 4)
        case .right3:
            .linear(mask: 0xFFFF_0000_0000, wrap: 4, linear: 12)
        }
    }
}
