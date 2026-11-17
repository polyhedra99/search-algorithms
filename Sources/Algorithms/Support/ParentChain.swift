//
//  ParentChain.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/29/26.
//

enum ParentChain {
    typealias State = UInt64
    
    static func walk(
        descendant: State,
        root: State,
        parents: [State: State]
    ) -> [State] {
        var chain: [State] = [descendant]
        var current: State = descendant

        while current != root {
            let parent: State = parents[current]!
            chain.append(parent)
            
            current = parent
        }

        return chain
    }
}
