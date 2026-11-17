//
//  Conveyor4x4+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/22/26.
//

import PuzzleRulesets

extension Conveyor4x4: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0,  1,  2,  3,
        4,  5,  6,  7,
        8,  9,  10, 11,
        12, 13, 14, 15
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
        case .left1: [
            1,  2,  3,  0,
            4,  5,  6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .right1: [
            3,  0,  1,  2,
            4,  5,  6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .left2: [
            0,  1,  2,  3,
            5,  6,  7,  4,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .right2: [
            0,  1,  2,  3,
            7,  4,  5,  6,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        case .left3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            9,  10, 11, 8,
            12, 13, 14, 15
        ]
        case .right3: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            11, 8,  9,  10,
            12, 13, 14, 15
        ]
        case .left4: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            8,  9,  10, 11,
            13, 14, 15, 12
        ]
        case .right4: [
            0,  1,  2,  3,
            4,  5,  6,  7,
            8,  9,  10, 11,
            15, 12, 13, 14
        ]
        case .up1: [
            4,  1,  2,  3,
            8,  5,  6,  7,
            12, 9,  10, 11,
            0,  13, 14, 15
        ]
        case .down1: [
            12, 1,  2,  3,
            0,  5,  6,  7,
            4,  9,  10, 11,
            8,  13, 14, 15
        ]
        case .up2: [
            0,  5,  2,  3,
            4,  9,  6,  7,
            8,  13, 10, 11,
            12, 1,  14, 15
        ]
        case .down2: [
            0,  13, 2,  3,
            4,  1,  6,  7,
            8,  5,  10, 11,
            12, 9,  14, 15
        ]
        case .up3: [
            0,  1,  6,  3,
            4,  5,  10, 7,
            8,  9,  14, 11,
            12, 13, 2,  15
        ]
        case .down3: [
            0,  1,  14, 3,
            4,  5,  2,  7,
            8,  9,  6,  11,
            12, 13, 10, 15
        ]
        case .up4: [
            0,  1,  2,  7,
            4,  5,  6,  11,
            8,  9,  10, 15,
            12, 13, 14, 3
        ]
        case .down4: [
            0,  1,  2,  15,
            4,  5,  6,  3,
            8,  9,  10, 7,
            12, 13, 14, 11
        ]
        }
    }
}
