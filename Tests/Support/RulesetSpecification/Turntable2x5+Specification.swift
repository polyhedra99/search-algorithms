//
//  Turntable2x5+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Turntable2x5: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0, 1, 2, 3, 4,
        5, 6, 7, 8, 9
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left0: [
            1, 6, 2, 3, 4,
            0, 5, 7, 8, 9
        ]
        case .right0: [
            5, 0, 2, 3, 4,
            6, 1, 7, 8, 9
        ]
        case .left1: [
            1, 2, 3, 4, 0,
            5, 6, 7, 8, 9
        ]
        case .right1: [
            4, 0, 1, 2, 3,
            5, 6, 7, 8, 9
        ]
        case .left2: [
            0, 1, 2, 3, 4,
            6, 7, 8, 9, 5
        ]
        case .right2: [
            0, 1, 2, 3, 4,
            9, 5, 6, 7, 8
        ]
        }
    }
}
