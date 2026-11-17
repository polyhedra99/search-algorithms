//
//  Pinwheel2x4+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Pinwheel2x4: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0, 1, 2, 3,
        4, 5, 6, 7
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left0: [
            0, 2, 6, 3,
            4, 1, 5, 7
        ]
        case .right0: [
            0, 5, 1, 3,
            4, 6, 2, 7
        ]
        case .left1: [
            1, 5, 2, 3,
            0, 4, 6, 7
        ]
        case .right1: [
            4, 0, 2, 3,
            5, 1, 6, 7
        ]
        case .left2: [
            0, 1, 3, 7,
            4, 5, 2, 6
        ]
        case .right2: [
            0, 1, 6, 2,
            4, 5, 7, 3
        ]
        }
    }
}
