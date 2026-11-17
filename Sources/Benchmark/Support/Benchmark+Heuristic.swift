//
//  Benchmark+Heuristic.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/9/26.
//

import PuzzleSearch
import Dispatch

extension Benchmark {
    struct HeuristicEvaluation {
        let depth: Int
        let averageStrength: Double
    }
    
    static func makePDBHeuristic(
        target: [Int],
        forEachPredecessor: @Sendable (State, (State) -> Void) -> Void
    ) -> (PDBHeuristic, timeElapsed: UInt64) {
        let tileSets: [Set<Int>] = [
            [0,  1,  2,  4,  8, 12],
            [3,  7, 11, 13, 14, 15],
            [1,  5,  8,  9, 10, 11],
            [4,  5,  6,  7, 10, 14],
            [0,  1,  2,  3,  4,  6],
            [9, 11, 12, 13, 14, 15]
        ]
        
        let startTime = DispatchTime.now().uptimeNanoseconds
        
        guard let pdbHeuristic = PDBHeuristic.make(
            target: target,
            tileSets: tileSets,
            forEachPredecessor: forEachPredecessor
        ) else { fatalError("Failed to make a PDB heuristic.") }
        
        let endTime = DispatchTime.now().uptimeNanoseconds
        
        return (pdbHeuristic, timeElapsed: endTime - startTime)
    }
    
    static func makeStrongPDBHeuristic(
        target: [Int],
        forEachPredecessor: @Sendable (State, (State) -> Void) -> Void
    ) -> (PDBHeuristic, timeElapsed: UInt64) {
        let tileSets: [Set<Int>] = [
            [0,  1,  2,  4,  8, 12],
            [3,  7, 11, 13, 14, 15],
            [1,  5,  8,  9, 10, 11, 12],
            [3,  4,  5,  6,  7, 10, 14],
            [0,  1,  2,  3,  4,  6, 10],
            [5,  9, 11, 12, 13, 14, 15]
        ]
        
        let startTime = DispatchTime.now().uptimeNanoseconds
        
        guard let pdbHeuristic = PDBHeuristic.make(
            target: target,
            tileSets: tileSets,
            forEachPredecessor: forEachPredecessor
        ) else { fatalError("Failed to make a PDB heuristic.") }
        
        let endTime = DispatchTime.now().uptimeNanoseconds
        
        return (pdbHeuristic, timeElapsed: endTime - startTime)
    }
    
    static func evaluateHeuristic(
        against oracle: [[State]],
        heuristic: (State) -> Distance
    ) -> [HeuristicEvaluation] {
        guard let maxPathLength = oracle.map(\.count).max(),
              maxPathLength > 0
        else { return [] }
        
        var sums: [Double] = Array(repeating: 0, count: maxPathLength)
        var counts: [Int] = Array(repeating: 0, count: maxPathLength)
        
        for path in oracle {
            for (index, state) in path.enumerated() {
                let depth = path.count - 1 - index
                
                sums[depth] += Double(heuristic(state)) / Double(depth)
                counts[depth] += 1
            }
        }
        
        return (1..<maxPathLength).reversed().map { depth in
            let strength = sums[depth] / Double(counts[depth])
            return HeuristicEvaluation(depth: depth, averageStrength: strength)
        }
    }
}
