//
//  RulesetSpecification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/22/26.
//

import PuzzleDomain
import PuzzleRulesets

protocol RulesetSpecification: Ruleset {
    static var expectedTarget: State { get }
}

protocol Nibble16RulesetSpecification: Nibble16Ruleset, RulesetSpecification {
    static var expectedTargetTiles: [Int] { get }
    
    static func expectedTiles(after move: Move) -> [Int]
}

extension Nibble16RulesetSpecification {
    static var expectedTarget: State {
        return makeState(from: expectedTargetTiles)!
    }
    
    static func expectedState(after move: Move) -> State {
        return makeState(from: expectedTiles(after: move))!
    }
}
