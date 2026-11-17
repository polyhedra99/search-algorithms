//
//  Benchmark+Run.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/8/26.
//

import Algorithms
import Dispatch

extension Benchmark {
    typealias State = UInt64
    typealias Distance = UInt8
    
    struct Metrics {
        let timeElapsed: UInt64
        let statesDiscovered: Int
        let statesExpanded: Int
        let path: [State]?
    }
    
    struct BiBFSMetrics {
        let metrics: Metrics
    }
    
    struct AStarMetrics {
        let metrics: Metrics
    }
    
    static func runBiBFS(
        endpoints: [SearchEndpoints],
        expectedDiscoveries: Int,
        forEachSuccessor: (State, (State) -> Void) -> Void,
        forEachPredecessor: (State, (State) -> Void) -> Void
    ) -> [BiBFSMetrics] {
        return endpoints.map { pair in
            let startTime = DispatchTime.now().uptimeNanoseconds
            
            var timeElapsed: UInt64 = 0
            var statesDiscovered: Int = 0
            var statesExpanded: Int = 0
            
            let searchResult = BiBFS.search(
                endpoints: pair,
                expectedDiscoveries: expectedDiscoveries,
                forEachSuccessor: forEachSuccessor,
                forEachPredecessor: forEachPredecessor
            ) { discovered, expanded in
                timeElapsed = DispatchTime.now()
                    .uptimeNanoseconds - startTime
                statesDiscovered = discovered
                statesExpanded = expanded
            }
            
            let path: [State]?
            switch searchResult {
            case let .success(foundPath): path = foundPath
            case .failure: path = nil
            }
            
            return BiBFSMetrics(metrics: Metrics(
                timeElapsed: timeElapsed,
                statesDiscovered: statesDiscovered,
                statesExpanded: statesExpanded,
                path: path
            ))
        }
    }
    
    static func runAStar(
        endpoints: [SearchEndpoints],
        expectedDiscoveries: Int,
        heuristic: (State) -> Distance,
        forEachSuccessor: (State, (State) -> Void) -> Void
    ) -> [AStarMetrics] {
        return endpoints.map { pair in
            let startTime = DispatchTime.now().uptimeNanoseconds
            
            var timeElapsed: UInt64 = 0
            var statesDiscovered: Int = 0
            var statesExpanded: Int = 0
            
            let searchResult = AStar.search(
                endpoints: pair,
                expectedDiscoveries: expectedDiscoveries,
                heuristic: heuristic,
                forEachSuccessor: forEachSuccessor
            ) { discovered, expanded in
                timeElapsed = DispatchTime.now()
                    .uptimeNanoseconds - startTime
                statesDiscovered = discovered
                statesExpanded = expanded
            }
            
            let path: [State]?
            switch searchResult {
            case let .success(foundPath): path = foundPath
            case .failure: path = nil
            }
            
            return AStarMetrics(metrics: Metrics(
                timeElapsed: timeElapsed,
                statesDiscovered: statesDiscovered,
                statesExpanded: statesExpanded,
                path: path
            ))
        }
    }
}
