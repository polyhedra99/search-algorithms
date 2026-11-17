//
//  AStar.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/28/26.
//

import DequeModule

public enum AStar {
    public typealias State = UInt64
    public typealias H = UInt8
    
    public enum SearchResult {
        case success(path: [State])
        case failure
    }
    
    /// Finds a shortest path using A*. The heuristic must be admissible;
    /// predecessor generation is not required.
    ///
    /// `expectedDiscoveries` reserves dictionary capacity and does not limit
    /// the search. `mainPhaseFinished` runs before path reconstruction.
    public static func search(
        endpoints: SearchEndpoints,
        expectedDiscoveries: Int = SearchDefaults.expectedDiscoveries,
        heuristic: (State) -> H,
        forEachSuccessor: (_ of: State, _ yield: (State) -> Void) -> Void,
        mainPhaseFinished: (_ statesDiscovered: Int, _ statesExpanded: Int) -> Void = { _, _ in }
    ) -> SearchResult {
        let targetResult = searchForTarget(
            endpoints: endpoints,
            expectedDiscoveries: expectedDiscoveries,
            heuristic: heuristic,
            forEachSuccessor: forEachSuccessor
        )
        
        mainPhaseFinished(
            targetResult.statesDiscovered,
            targetResult.statesExpanded
        )
        
        guard let parents = targetResult.parents
        else { return .failure }
        
        let path = reconstructPath(
            endpoints: endpoints,
            parents: parents
        )
        
        return .success(path: path)
    }
}

extension AStar {
    static func reconstructPath(
        endpoints: SearchEndpoints,
        parents: [State: State]
    ) -> [State] {
        let path = ParentChain.walk(
            descendant: endpoints.target,
            root: endpoints.origin,
            parents: parents
        )
        
        return path.reversed()
    }
}
