//
//  PDBHeuristic+Target.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

import NibblePacking

public extension PDBHeuristic {
    struct Target: Sendable {
        let array: [Int]
        
        var packed: State { State(nibbles: array) }
        
        init?(_ array: [Int]) {
            guard array.count == PDBHeuristic.cellCount,
                  Set(array) == Set(0...15),
                  array.isNibblePackable
            else { return nil }
            
            self.array = array
        }
    }
}
