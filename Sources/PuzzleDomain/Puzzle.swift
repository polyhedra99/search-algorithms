//
//  Puzzle.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/7/26.
//

public struct Puzzle<R: Ruleset>: Equatable, Sendable {
    public let target: R.State
    
    public init(target: R.State) {
        precondition(!R.Move.allCases.isEmpty)
        
        self.target = target
    }
    
    /// Applies `moveCount` random moves to the target.
    ///
    /// The result is reachable but is not guaranteed to differ from the target
    /// or to require exactly `moveCount` moves to solve.
    public func makeShuffle(
        moveCount: Int,
        randomMove: () -> R.Move = { R.Move.allCases.randomElement()! }
    ) -> R.State {
        precondition(moveCount >= 0)
        
        var shuffled = self.target
        for _ in 0..<moveCount {
            shuffled = R.applying(move: randomMove(), to: shuffled)
        }
        
        return shuffled
    }
    
    public func didReachSolution(_ state: R.State) -> Bool {
        return state == self.target
    }
}
