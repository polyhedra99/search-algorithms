//
//  BiBFS+Intersection.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/16/26.
//

import DequeModule

extension BiBFS {
    struct IntersectionSearchResult {
        let intersection: State?
        
        let statesDiscovered: Int
        let statesExpanded: Int
    }

    static func searchForIntersection(
        endpoints: SearchEndpoints,
        expectedDiscoveries: Int,
        forEachSuccessor: (State, (State) -> Void) -> Void,
        forEachPredecessor: (State, (State) -> Void) -> Void
    ) -> IntersectionSearchResult {
        var discovered: [State: Side] = [
            endpoints.origin: .origin,
            endpoints.target: .target
        ]
        discovered.reserveCapacity(expectedDiscoveries)

        var originAgenda: Deque<State> = [endpoints.origin]
        var targetAgenda: Deque<State> = [endpoints.target]

        var intersection: State? = nil

        while !originAgenda.isEmpty && !targetAgenda.isEmpty {
            if let expansionResult = expandLevel(
                agenda: &originAgenda,
                side: .origin,
                discovered: &discovered,
                forEachChild: forEachSuccessor
            ) ?? expandLevel(
                agenda: &targetAgenda,
                side: .target,
                discovered: &discovered,
                forEachChild: forEachPredecessor
            ) {
                intersection = expansionResult
                break
            }
        }

        let statesDiscovered = discovered.count
        let agendaRemnants = originAgenda.count + targetAgenda.count
        let statesExpanded = statesDiscovered - agendaRemnants
        
        return IntersectionSearchResult(
            intersection: intersection,
            statesDiscovered: statesDiscovered,
            statesExpanded: statesExpanded
        )
    }
}

fileprivate extension BiBFS {
    enum Side {
        case origin
        case target
    }

    static func expandLevel(
        agenda: inout Deque<State>,
        side: Side,
        discovered: inout [State: Side],
        forEachChild: (State, (State) -> Void) -> Void
    ) -> State? {
        let levelSize = agenda.count
        var intersection: State? = nil

        for _ in 0..<levelSize {
            let current = agenda.popFirst()!

            forEachChild(current) { child in
                if let previous = discovered.updateValue(
                    side,
                    forKey: child
                ) {
                    guard previous != side else { return }

                    intersection = child
                    return
                }

                agenda.append(child)
            }

            guard intersection == nil else { break }
        }

        return intersection
    }
}
