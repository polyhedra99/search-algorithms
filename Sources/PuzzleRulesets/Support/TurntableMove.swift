//
//  TurntableMove.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public protocol TurntableMove {
    var displacement: TurntableDisplacement { get }
}

public enum TurntableDisplacement {
    case ring(right: UInt64, down: UInt64, left: UInt64, up: UInt64)
    case linear(mask: UInt64, wrap: Int, linear: Int)
}

public extension Nibble16Ruleset where Move: TurntableMove {
    @inlinable static func applying(move: Move, to state: State) -> State {
        switch move.displacement {
        case let .ring(right, down, left, up):
            let block: UInt64 = right | down | left | up
            let masked: UInt64 = state & block

            let columnBits: Int = dimensions.columnCount * 4
            let ring: UInt64 = (state & right) << 4
                | (state & down) << columnBits
                | (state & left) >> 4
                | (state & up) >> columnBits

            return ring | (state ^ masked)

        case let .linear(mask, wrap, linear):
            let masked: UInt64 = state & mask
            let band: UInt64 = (masked << wrap | masked >> linear) & mask

            return band | (state ^ masked)
        }
    }
}
