//
//  PDBHeuristic+Ranker.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

import NibblePacking

public extension PDBHeuristic {
    struct Ranker: Sendable {
        public typealias TrackedTiles = UInt64
        
        public let trackedTiles: TrackedTiles
        public let patternSize: Int
        
        init(pattern: Pattern) {
            self.trackedTiles = TrackedTiles(nibbles: pattern.trackedTiles)
            self.patternSize = pattern.configuration.patternSize
        }
        
        /// Ranks tracked-tile positions as a partial permutation of 16 cells.
        ///
        /// The result is a unique index in `0..<(16! / (16 - patternSize)!)`.
        /// `positions` must use the packing produced by `extractPositions`.
        @inlinable func rank(positions: Positions) -> Int {
            let tileZero = self.trackedTiles & 0xF
            let positionZero = Int(positions >> (tileZero * 4) & 0xF)
            
            var rank = positionZero
            var seen: UInt16 = 1 << positionZero
            
            for order in 1..<6 {
                let tile = self.trackedTiles >> (order * 4) & 0xF
                let position = Int(positions >> (tile * 4) & 0xF)
                
                let belowPosition: UInt16 = (1 << position) - 1
                let digit = position - (seen & belowPosition).nonzeroBitCount
                
                rank = rank * (16 - order) + digit
                seen |= 1 << position
            }
            
            guard self.patternSize == 7 else { return rank }
            
            let tile = self.trackedTiles >> 24 & 0xF
            let position = Int(positions >> (tile * 4) & 0xF)
            
            let belowPosition: UInt16 = (1 << position) - 1
            let digit = position - (seen & belowPosition).nonzeroBitCount
            
            return rank * 10 + digit
        }
    }
}
