//
//  Ruleset.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/12/26.
//

public protocol Ruleset {
    associatedtype State: Equatable, Sendable
    associatedtype Move: CaseIterable
    
    static func applying(move: Move, to state: State) -> State
}
