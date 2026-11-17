//
//  PDBHeuristic+PDB.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

import Algorithms
import NibblePacking

public extension PDBHeuristic {
    struct PDB: Sendable {
        public let distances: [Distance]
        public let ranker: Ranker
        
        fileprivate init(distances: [Distance], ranker: Ranker) {
            self.distances = distances
            self.ranker = ranker
        }
        
        /// Looks up the distance for precomputed tile positions.
        @inlinable func distance(positions: Positions) -> Distance {
            let rank = self.ranker.rank(positions: positions)
            return self.distances[rank]
        }
        
        static func make(
            pattern: Pattern,
            forEachPredecessor: (_ of: State, _ yield: (State) -> Void) -> Void
        ) -> Self {
            let ranker = Ranker(pattern: pattern)
            
            let rankState: (State) -> Int = {
                let positions = PDBHeuristic.extractPositions(from: $0)
                return ranker.rank(positions: positions)
            }
            
            let abstractDistances = BFS.distances(
                from: pattern.masking(pattern.target.packed),
                tableSize: pattern.configuration.stateCount,
                ranker: rankState,
                forEachPredecessor: forEachPredecessor
            )
            
            return Self(distances: abstractDistances, ranker: ranker)
        }
    }
}
