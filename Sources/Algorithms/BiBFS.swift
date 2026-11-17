//
//  BiBFS.swift
//  search-algorithms
//
//  Created by Mykhailo on 9/28/26.
//

public enum BiBFS {
    // TODO: Add this as a product?
    public typealias State = UInt64
    
    public enum SearchResult {
        case success(path: [State])
        case failure
    }
    
    /// Finds a shortest path by expanding from both endpoints.
    ///
    /// Successors lead away from the origin; predecessors lead toward the
    /// target. `expectedDiscoveries` reserves capacity for both directions.
    /// `mainPhaseFinished` runs before path reconstruction.
    public static func search(
        endpoints: SearchEndpoints,
        expectedDiscoveries: Int = SearchDefaults.expectedDiscoveries,
        forEachSuccessor: (_ of: State, _ yield: (State) -> Void) -> Void,
        forEachPredecessor: (_ of: State, _ yield: (State) -> Void) -> Void,
        mainPhaseFinished: (_ statesDiscovered: Int, _ statesExpanded: Int) -> Void = { _, _ in }
    ) -> SearchResult {
        let intersectionResult = searchForIntersection(
            endpoints: endpoints,
            expectedDiscoveries: expectedDiscoveries,
            forEachSuccessor: forEachSuccessor,
            forEachPredecessor: forEachPredecessor
        )
        
        mainPhaseFinished(
            intersectionResult.statesDiscovered,
            intersectionResult.statesExpanded
        )
        
        guard let intersection = intersectionResult.intersection
        else { return .failure }
        
        let path = reconstructPath(
            endpoints: endpoints,
            intersection: intersection,
            forEachSuccessor: forEachSuccessor,
            forEachPredecessor: forEachPredecessor
        )
        
        return .success(path: path)
    }
}

extension BiBFS {
    static func reconstructPath(
        endpoints: SearchEndpoints,
        intersection: State,
        forEachSuccessor: (State, (State) -> Void) -> Void,
        forEachPredecessor: (State, (State) -> Void) -> Void
    ) -> [State] {
        func walk(from origin: State, to target: State) -> [State] {
            guard let endpoints = SearchEndpoints(origin: origin, target: target),
                  let path = findPath(
                    endpoints: endpoints,
                    forEachSuccessor: forEachSuccessor,
                    forEachPredecessor: forEachPredecessor
                  )
            else { return [] }
            
            return path
        }
        
        let originToIntersection = walk(from: endpoints.origin, to: intersection)
        let intersectionToTarget = walk(from: intersection, to: endpoints.target)
        
        let path = originToIntersection + intersectionToTarget.dropFirst()
        return path
    }
}
