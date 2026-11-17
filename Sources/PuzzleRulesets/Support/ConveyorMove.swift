//
//  ConveyorMove.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleDomain

public protocol ConveyorMove {
    var mask: UInt64 { get }
    var shifts: (wrap: Int, linear: Int) { get }
}

public extension Nibble16Ruleset where Move: ConveyorMove {
    @inlinable static func applying(move: Move, to state: State) -> State {
        let mask = move.mask
        let masked = state & mask
        
        let (wrap, linear) = move.shifts
        let moved = ((masked << wrap) | (masked >> linear)) & mask
        
        return moved | (state ^ masked)
    }
}
