//
//  AStar+Target.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/29/26.
//

import DequeModule

extension AStar {
    typealias Entry = BucketQueue.Entry
    typealias G = BucketQueue.G
    
    struct TargetSearchResult {
        let parents: [State: State]?
        
        let statesDiscovered: Int
        let statesExpanded: Int
    }
    
    static func searchForTarget(
        endpoints: SearchEndpoints,
        expectedDiscoveries: Int,
        heuristic: (State) -> H,
        forEachSuccessor: (_ of: State, _ yield: (State) -> Void) -> Void
    ) -> TargetSearchResult {
        let originEntry = Entry(
            state: endpoints.origin,
            fValue: heuristic(endpoints.origin),
            gValue: 0
        )
        
        var bestG: [State: G] = [originEntry.state: originEntry.gValue]
        bestG.reserveCapacity(expectedDiscoveries)
        
        var parents: [State: State] = [
            endpoints.origin: endpoints.origin
        ]
        parents.reserveCapacity(expectedDiscoveries)
        
        var agenda: BucketQueue = [originEntry]
        var statesExpanded: Int = 0
        var targetReached: Bool = false
        
        while let current = agenda.pop() {
            guard current.gValue == bestG[current.state]
            else { continue }
            
            statesExpanded += 1
            
            if current.state == endpoints.target {
                targetReached = true
                break
            }
            
            let nextG: G = current.gValue &+ 1
            
            forEachSuccessor(current.state) { [heuristic] successor in
                guard nextG < bestG[successor, default: .max]
                else { return }
                
                let successorEntry = Entry(
                    state: successor,
                    fValue: heuristic(successor) &+ nextG,
                    gValue: nextG
                )
                
                bestG[successor] = nextG
                parents[successor] = current.state
                agenda.push(successorEntry)
            }
        }
        
        return TargetSearchResult(
            parents: targetReached ? parents : nil,
            statesDiscovered: parents.count,
            statesExpanded: statesExpanded
        )
    }
}
