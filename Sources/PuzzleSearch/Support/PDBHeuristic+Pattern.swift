//
//  PDBTarget+Pattern.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

public extension PDBHeuristic {
    struct Pattern: Sendable {
        let target: Target
        let trackedTiles: [Int]
        let configuration: Configuration
        let sentinels: State
        
        init?(target: Target, tileSet: TileSet) {
            guard let configuration = Configuration(tileCount: tileSet.count),
                  tileSet.allSatisfy(target.array.contains(_:))
            else { return nil }
            
            let trackedTiles = tileSet.sorted()
            guard let sentinel = (0x0...0xF)
                .first(where: { !trackedTiles.contains($0) })
            else { return nil }
            
            self.target = target
            self.trackedTiles = trackedTiles
            self.configuration = configuration
            self.sentinels = State.filledWith(nibble: sentinel)
        }
        
        /// Replaces untracked tiles with a sentinel while preserving tracked tiles.
        func masking(_ state: State) -> State {
            var masked: State = self.sentinels
            
            for cell in 0..<PDBHeuristic.cellCount {
                let nibble = state >> (cell * 4) & 0xF
                
                guard self.trackedTiles.contains(Int(nibble))
                else { continue }
                
                masked &= ~(0xF << (cell * 4))
                masked |= nibble << (cell * 4)
            }
            
            return masked
        }
    }
}
