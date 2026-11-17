//
//  PDBHeuristic.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/26/26.
//

import Foundation

public struct PDBHeuristic {
    public typealias State = UInt64
    public typealias Distance = UInt8
    public typealias TileSet = Set<Int>
    
    public let pdbs: [PDB]
    
    public static let cellCount: Int = 16
    
    /// Returns the maximum pattern-database distance for `state`.
    @inlinable public func maxDistance(from state: State) -> Distance {
        var maxDistance: Distance = 0
        let positions = PDBHeuristic.extractPositions(from: state)
        
        for pdb in self.pdbs {
            maxDistance = max(maxDistance, pdb.distance(positions: positions))
        }
        
        return maxDistance
    }
    
    /// Builds six- or seven-tile pattern databases concurrently.
    ///
    /// Each tile set must contain six or seven tiles from `target`, which must
    /// be a permutation of `0...15`. Predecessors are used to compute distances
    /// toward the target. Returns `nil` for invalid input.
    public static func make(
        target: [Int],
        tileSets: [TileSet],
        forEachPredecessor: @Sendable (_ of: State, _ yield: (State) -> Void) -> Void
    ) -> Self? {
        guard let target = Target(target) else { return nil }
        
        let patterns = tileSets.compactMap { Pattern(target: target, tileSet: $0) }
        guard patterns.count == tileSets.count else { return nil }
        
        let lock = NSLock()
        nonisolated(unsafe) var pdbs: [PDB?] = Array(
            repeating: nil,
            count: patterns.count
        )
        
        DispatchQueue.concurrentPerform(
            iterations: patterns.count
        ) { index in
            let pdb = PDB.make(
                pattern: patterns[index],
                forEachPredecessor: forEachPredecessor
            )
            
            lock.lock()
            pdbs[index] = pdb
            lock.unlock()
        }
        
        return Self(pdbs: pdbs.map { $0! })
    }
}

public extension PDBHeuristic {
    typealias Positions = UInt64
    
    /// Packs each tile's cell into the nibble indexed by that tile.
    @inlinable static func extractPositions(from state: State) -> Positions {
        var positions: Positions = 0
        
        for cell in 0..<Self.cellCount {
            let tile = state >> (cell * 4) & 0xF
            positions |= Positions(cell) << (tile * 4)
        }
        
        return positions
    }
}
