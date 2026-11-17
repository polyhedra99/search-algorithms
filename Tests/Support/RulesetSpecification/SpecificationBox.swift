//
//  SpecificationBox.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/27/26.
//

import PuzzleRulesets

struct SpecificationBox: @unchecked Sendable {
    var type: any Nibble16RulesetSpecification.Type
    
    init<T: Nibble16RulesetSpecification>(_ type: T.Type) {
        self.type = type
    }
}

extension SpecificationBox {
    static let predefinedBoxes: [SpecificationBox] = [
        SpecificationBox(Conveyor3x4.self),
        SpecificationBox(Conveyor4x4.self),
        SpecificationBox(Pinwheel2x4.self),
        SpecificationBox(Pinwheel4x4.self),
        SpecificationBox(Turntable2x3.self),
        SpecificationBox(Turntable2x5.self),
        SpecificationBox(Turntable3x4.self)
    ]
}
