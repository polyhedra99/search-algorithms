//
//  Samples.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/9/26.
//

import PuzzleDomain
import PuzzleRulesets
import PuzzleSearch

extension Benchmark {
    enum Samples {
        fileprivate static let conveyorLabel: String = "Conveyor4x4"
        fileprivate static let pinwheelLabel: String = "Pinwheel4x4"
        
        fileprivate static let conveyorBiBFSDiscoveries: Int = 58_000_000
        fileprivate static let conveyorAStarDiscoveries: Int = 3_600_000
        fileprivate static let pinwheelAStarDiscoveries: Int = 24_600_000
        
        static func runFullOnConveyor4x4(runs: Int) {
            guard let puzzle = Puzzle<Conveyor4x4>(targetArray: Array(0...15))
            else { fatalError("Failed to make a puzzle.") }
            
            let endpoints = makeEndpoints(for: puzzle, count: runs)
            
            let biBFSMetrics = runBiBFS(
                endpoints: endpoints,
                expectedDiscoveries: conveyorBiBFSDiscoveries,
                forEachSuccessor: puzzle.forEachSuccessor(of:yield:),
                forEachPredecessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makeRunReport(from: biBFSMetrics, ruleset: conveyorLabel).underlined())
            
            let (pdbs, pdbTime) = makePDBHeuristic(
                target: puzzle.targetElements,
                forEachPredecessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makePDBReport(timeElapsed: pdbTime).underlined())
            
            let aStarMetrics = runAStar(
                endpoints: endpoints,
                expectedDiscoveries: conveyorAStarDiscoveries,
                heuristic: pdbs.maxDistance(from:),
                forEachSuccessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makeRunReport(from: aStarMetrics, ruleset: conveyorLabel).underlined())
            
            let evaluations = evaluateHeuristic(
                against: biBFSMetrics.map(\.metrics).compactMap(\.path),
                heuristic: pdbs.maxDistance(from:)
            )
            
            print(makeHeuristicReport(evaluations: evaluations).underlined())
            print(makeValidationReport(
                paths: aStarMetrics.map(\.metrics).map(\.path),
                oracle: biBFSMetrics.map(\.metrics).map(\.path)).underlined())
        }
        
        static func runAStarOnConveyor4x4(runs: Int) {
            guard let puzzle = Puzzle<Conveyor4x4>(targetArray: Array(0...15))
            else { fatalError("Failed to make a puzzle.") }
            
            let (pdbs, pdbTime) = makePDBHeuristic(
                target: puzzle.targetElements,
                forEachPredecessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makePDBReport(timeElapsed: pdbTime).underlined())
            
            let endpoints = makeEndpoints(for: puzzle, count: runs)
            
            let aStarMetrics = runAStar(
                endpoints: endpoints,
                expectedDiscoveries: conveyorAStarDiscoveries,
                heuristic: pdbs.maxDistance(from:),
                forEachSuccessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makeRunReport(from: aStarMetrics, ruleset: conveyorLabel).underlined())
            
            let evaluations = evaluateHeuristic(
                against: aStarMetrics.map(\.metrics).compactMap(\.path),
                heuristic: pdbs.maxDistance(from:)
            )
            
            print(makeHeuristicReport(evaluations: evaluations).underlined())
        }
        
        static func runAStarOnPinwheel4x4(runs: Int) {
            guard let puzzle = Puzzle<Pinwheel4x4>(targetArray: Array(0...15))
            else { fatalError("Failed to make a puzzle.") }
            
            let (pdbs, pdbTime) = makeStrongPDBHeuristic(
                target: puzzle.targetElements,
                forEachPredecessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makePDBReport(timeElapsed: pdbTime).underlined())
            
            let endpoints = makeEndpoints(for: puzzle, count: runs)
            
            let aStarMetrics = runAStar(
                endpoints: endpoints,
                expectedDiscoveries: pinwheelAStarDiscoveries,
                heuristic: pdbs.maxDistance(from:),
                forEachSuccessor: puzzle.forEachSuccessor(of:yield:)
            )
            
            print(makeRunReport(from: aStarMetrics, ruleset: pinwheelLabel).underlined())
            
            let evaluations = evaluateHeuristic(
                against: aStarMetrics.map(\.metrics).compactMap(\.path),
                heuristic: pdbs.maxDistance(from:)
            )
            
            print(makeHeuristicReport(evaluations: evaluations).underlined())
        }
    }
}
