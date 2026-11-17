//
//  BFS.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/24/26.
//

import DequeModule

public enum BFS {
    public typealias State = UInt64
    public typealias Distance = UInt8
    
    public static let unreachable: Distance = .max
    
    /// Returns rank-indexed distances to `origin`, found by reverse BFS.
    ///
    /// `ranker` must map every visited state to a unique index in
    /// `0..<tableSize`. Unvisited ranks contain `unreachable`.
    public static func distances(
        from origin: State,
        tableSize: Int,
        ranker: (State) -> Int,
        forEachPredecessor: (_ of: State, _ yield: (State) -> Void) -> Void
    ) -> [Distance] {
        var distances: [Distance] = Array(repeating: unreachable, count: tableSize)
        
        let originRank = ranker(origin)
        distances[originRank] = 0
        
        var agenda: Deque<State> = [origin]
        var nextLevel: Distance = 1
        
        while !agenda.isEmpty {
            let levelSize = agenda.count
            
            for _ in 0..<levelSize {
                let current = agenda.popFirst()!
                
                forEachPredecessor(current) { [ranker] predecessor in
                    guard current != predecessor else { return }
                    
                    let rank = ranker(predecessor)
                    guard distances[rank] == Self.unreachable else { return }
                    
                    distances[rank] = nextLevel
                    agenda.append(predecessor)
                }
            }
            
            nextLevel += 1
        }
        
        return distances
    }
}
