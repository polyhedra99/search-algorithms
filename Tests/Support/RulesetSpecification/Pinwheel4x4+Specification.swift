//
//  Pinwheel4x4+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Pinwheel4x4: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0,  1,  2,  3,
        4,  5,  6,  7,
        8,  9,  10, 11,
        12, 13, 14, 15
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left0: [
            0,  1,  2,  3,
            4,  6,  10, 7,
            8,  5,  9,  11,
            12, 13, 14, 15
        ]
        case .right0: [
            0,  1,  2,  3,
            4,  9,  5,  7,
            8,  10, 6,  11,
            12, 13, 14, 15
        ]
        case .left1: [
            1,  5,  2,  3,
            0,  4,  6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .right1: [
            4,  0,  2,  3,
            5,  1,  6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .left2: [
            0,  1,  3,  7,
            4,  5,  2,  6,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .right2: [
            0,  1,  6,  2,
            4,  5,  7,  3,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .left3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            9,  13, 10, 11,
            8,  12, 14, 15
        ]
        case .right3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            12, 8,  10, 11,
            13, 9,  14, 15
        ]
        case .left4: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            8,  9,  11, 15,
            12, 13, 10, 14
        ]
        case .right4: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            8,  9,  14, 10,
            12, 13, 15, 11
        ]
        }
    }
}
