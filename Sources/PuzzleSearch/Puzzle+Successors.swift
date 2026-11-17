//
//  Puzzle+Successors.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/18/26.
//

import PuzzleDomain

public extension Puzzle {
    /// Yields every state reachable by one move. Usable as a predecessor
    /// generator when `R.Move.allCases` closes every move with its inverse.
    @inlinable @Sendable func forEachSuccessor(of state: R.State, yield: (R.State) -> Void) {
        for move in R.Move.allCases {
            yield(R.applying(move: move, to: state))
        }
    }
}
