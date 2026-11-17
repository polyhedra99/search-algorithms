import Testing
@testable import CustomTags
@testable import PuzzleRulesets
@testable import RulesetSpecification

@Suite("Common Nibble16Ruleset tests", .tags(.behavior))
enum CommonNibble16RulesetTests {
    @Test(
        "All individual moves",
        .tags(.success),
        arguments: SpecificationBox.predefinedBoxes
    )
    static func allIndividualMoves(box: SpecificationBox) {
        func open<T: Nibble16RulesetSpecification>(_ type: T.Type) {
            let original: T.State = type.expectedTarget
            
            for move in T.Move.allCases {
                let expected: T.State = type.expectedState(after: move)
                let actual: T.State = type.applying(move: move, to: original)
                
                #expect(actual == expected, """
                    Move: \(move)
                    Expected: \(expected.unpackNibbles(count: type.dimensions.cellCount))
                    Actual: \(actual.unpackNibbles(count: type.dimensions.cellCount))
                    """
                )
            }
        }
        
        open(box.type)
    }
    
    @Test(
        "Moveset is inverse closed",
        .tags(.success),
        arguments: SpecificationBox.predefinedBoxes
    )
    static func movesetIsInverseClosed(box: SpecificationBox) {
        func open<T: Nibble16RulesetSpecification>(_ type: T.Type) {
            let original: T.State = type.expectedTarget
            let samples = T.Move.allCases.map { move in
                type.applying(move: move, to: original)
            }
            
            for sample in samples {
                let undoExists = T.Move.allCases.contains { move in
                    type.applying(move: move, to: sample) == original
                }
                
                #expect(undoExists)
            }
        }
        
        open(box.type)
    }
}
