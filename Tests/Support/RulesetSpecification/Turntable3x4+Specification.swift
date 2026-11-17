//
//  Turntable3x4+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Turntable3x4: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0,  1,  2,  3,
        4,  5,  6,  7,
        8,  9,  10, 11
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left0: [
            1,  5,  2,  3,
            0,  9,  6,  7,
            4,  8,  10, 11
        ]
        case .right0: [
            4,  0,  2,  3,
            8,  1,  6,  7,
            9,  5,  10, 11
        ]
        case .left1: [
            1,  2,  3,  0,
            4,  5,  6,  7,
            8,  9,  10, 11
        ]
        case .right1: [
            3,  0,  1,  2,
            4,  5,  6,  7,
            8,  9,  10, 11
        ]
        case .left2: [
            0,  1,  2,  3,
            5,  6,  7,  4,
            8,  9,  10, 11
        ]
        case .right2: [
            0,  1,  2,  3,
            7,  4,  5,  6,
            8,  9,  10, 11
        ]
        case .left3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            9,  10, 11, 8
        ]
        case .right3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            11, 8,  9,  10
        ]
        }
    }
}
