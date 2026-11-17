import Testing
import NibblePacking
@testable import CustomTags
@testable import PuzzleSearch

@Suite("PDB Heuristic")
enum PDBHeuristicTests {
    @Test(
        "Positions extraction",
        .tags(.behavior, .success),
        arguments: [
            (array: Array(0...15),
             expectedPositions: Array(0...15)),
            (array: (Array(0...15).reversed()),
             expectedPositions: Array(0...15).reversed()),
            (array: [8, 0, 12, 5, 2, 9, 14, 1, 6, 3, 10, 7, 4, 11, 13, 15],
             expectedPositions: [1, 7, 4, 9, 12, 3, 8, 11, 0, 5, 10, 13, 2, 14, 6, 15])
        ]
    )
    static func positionsExtraction(array: [Int], expectedPositions: [Int]) {
        let state = UInt64(nibbles: array)
        let positions = PDBHeuristic.extractPositions(from: state)
        
        #expect(positions == UInt64(nibbles: expectedPositions))
    }
}
