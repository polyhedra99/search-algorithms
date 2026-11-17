//
//  Turntable2x3+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Turntable2x3: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0, 1, 2,
        3, 4, 5
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left0: [
            3, 1, 2,
            0, 4, 5
        ]
        case .right0: [
            3, 1, 2,
            0, 4, 5
        ]
        case .left1: [
            1, 2, 0,
            3, 4, 5
        ]
        case .right1: [
            2, 0, 1,
            3, 4, 5
        ]
        case .left2: [
            0, 1, 2,
            4, 5, 3
        ]
        case .right2: [
            0, 1, 2,
            5, 3, 4
        ]
        }
    }
}
