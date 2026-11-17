//
//  BiBFS+Pathfinding.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/17/26.
//

import DequeModule

extension BiBFS {
    static func findPath(
        endpoints: SearchEndpoints,
        forEachSuccessor: (State, (State) -> Void) -> Void,
        forEachPredecessor: (State, (State) -> Void) -> Void
    ) -> [State]? {
        let origin: State = endpoints.origin
        let target: State = endpoints.target
        
        var originVisited: [State: State] = [origin: origin]
        var targetVisited: [State: State] = [target: target]
        
        var originAgenda: Deque<State> = [origin]
        var targetAgenda: Deque<State> = [target]
        
        var intersection: State? = nil
        
        while !originAgenda.isEmpty && !targetAgenda.isEmpty {
            if let expansionResult = expandLevel(
                agenda: &originAgenda,
                visited: &originVisited,
                otherVisited: targetVisited,
                forEachChild: forEachSuccessor
            ) ?? expandLevel(
                agenda: &targetAgenda,
                visited: &targetVisited,
                otherVisited: originVisited,
                forEachChild: forEachPredecessor
            ) {
                intersection = expansionResult
                break
            }
        }
        
        guard let intersection = intersection
        else { return nil }
        
        let originHalf = ParentChain.walk(
            descendant: intersection,
            root: origin,
            parents: originVisited
        )
        
        let targetHalf = ParentChain.walk(
            descendant: intersection,
            root: target,
            parents: targetVisited
        )
        
        let path: [State] = originHalf.reversed() + targetHalf.dropFirst()
        return path
    }
}

fileprivate extension BiBFS {
    static func expandLevel(
        agenda: inout Deque<State>,
        visited: inout [State: State],
        otherVisited: [State: State],
        forEachChild: (State, (State) -> Void) -> Void
    ) -> State? {
        let levelSize = agenda.count
        var intersection: State? = nil

        for _ in 0..<levelSize {
            let current = agenda.popFirst()!

            forEachChild(current) { child in
                guard visited[child] == nil else { return }
                visited[child] = current
                
                if otherVisited[child] != nil {
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
