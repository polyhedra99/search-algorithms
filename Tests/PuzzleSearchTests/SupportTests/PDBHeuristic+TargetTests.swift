import Testing
import NibblePacking
@testable import CustomTags
@testable import PuzzleSearch

@Suite("PDB Heuristic Target", .tags(.initialization))
enum TargetTests {
    @Test(
        "Valid n with distinct tiles",
        .tags(.success),
        arguments: [Array(0...15), Array(0...15).reversed()]
    )
    static func validN(array: [Int]) throws {
        let target = try #require(PDBHeuristic.Target(array))
        
        #expect(target.array == array)
        #expect(target.packed == UInt64(nibbles: array))
    }
    
    @Test(
        "Out of bounds n",
        .tags(.failure),
        arguments: [Array(0...14), Array(0...16)]
    )
    static func outOfBoundsN(array: [Int]) {
        #expect(PDBHeuristic.Target(array) == nil)
    }
    
    @Test(
        "Non-distinct input",
        .tags(.failure),
        arguments: [[0] + Array(0...14), Array(1...15) + [15]]
    )
    static func nonDistinct(array: [Int]) {
        #expect(PDBHeuristic.Target(array) == nil)
    }
}
