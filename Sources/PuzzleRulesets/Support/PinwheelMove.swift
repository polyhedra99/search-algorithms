//
//  PinwheelMove.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public protocol PinwheelMove {
    var anchorCell: Int { get }
    var isClockwise: Bool { get }
}

public extension PinwheelMove {
    var blockMasks: (a: UInt64, b: UInt64, c: UInt64, d: UInt64) {
        let anchorBit: Int = self.anchorCell * 4
        
        let a: UInt64 = 0xF << anchorBit
        let b: UInt64 = a << 4
        let c: UInt64 = a << 16
        let d: UInt64 = a << 20
        
        return (a: a, b: b, c: c, d: d)
    }
}

public extension Nibble16Ruleset where Move: PinwheelMove {
    @inlinable static func applying(move: Move, to state: State) -> State {
        let (a, b, c, d) = move.blockMasks
        let block = a | b | c | d
        let masked = state & block
        
        let moved = move.isClockwise
            ? (state & a) <<  4 | (state & b) << 16 | (state & c) >> 16 | (state & d) >>  4
            : (state & a) << 16 | (state & b) >>  4 | (state & c) <<  4 | (state & d) >> 16
        
        return moved | (state ^ masked)
    }
}
