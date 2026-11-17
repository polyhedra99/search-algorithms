//
//  Conveyor3x4+Specification.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/23/26.
//

import PuzzleRulesets

extension Conveyor3x4: Nibble16RulesetSpecification {
    static let expectedTargetTiles: [Int] = [
        0,  1,  2,  3,
        4,  5,  6,  7,
        8,  9,  10, 11
    ]
    
    static func expectedTiles(after move: Move) -> [Int] {
        return switch move {
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
        case .up1: [
            4,  1,  2,  3,
            8,  5,  6,  7,
            0,  9,  10, 11,
        ]
        case .down1: [
            8,  1,  2,  3,
            0,  5,  6,  7,
            4,  9,  10, 11
        ]
        case .up2: [
            0,  5,  2,  3,
            4,  9,  6,  7,
            8,  1,  10, 11,
        ]
        case .down2: [
            0,  9,  2,  3,
            4,  1,  6,  7,
            8,  5,  10, 11
        ]
        case .up3: [
            0,  1,  6,  3,
            4,  5,  10, 7,
            8,  9,  2,  11
        ]
        case .down3: [
            0,  1,  10, 3,
            4,  5,  2,  7,
            8,  9,  6,  11
        ]
        case .up4: [
            0,  1,  2,  7,
            4,  5,  6,  11,
            8,  9,  10, 3,
        ]
        case .down4: [
            0,  1,  2,  11,
            4,  5,  6,  3,
            8,  9,  10, 7
        ]
        }
    }
}
