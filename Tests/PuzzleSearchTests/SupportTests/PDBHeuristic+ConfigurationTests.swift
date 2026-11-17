import Testing
@testable import CustomTags
@testable import PuzzleSearch

@Suite("PDB Heuristic Configuration", .tags(.initialization))
enum ConfigurationTests {
    @Test("6 tiles", .tags(.success))
    static func sixTiles() throws {
        let configuration = try #require(
            PDBHeuristic.Configuration(tileCount: 6))
        let expectedStates: Int = 16 * 15 * 14 * 13 * 12 * 11
        
        #expect(configuration.patternSize == 6)
        #expect(configuration.stateCount == expectedStates)
    }
    
    @Test("7 tiles", .tags(.success))
    static func sevenTiles() throws {
        let configuration = try #require(
            PDBHeuristic.Configuration(tileCount: 7))
        let expectedStates: Int = 16 * 15 * 14 * 13 * 12 * 11 * 10
        
        #expect(configuration.patternSize == 7)
        #expect(configuration.stateCount == expectedStates)
    }
    
    @Test(
        "Out of bounds tile count",
        .tags(.failure),
        arguments: [5, 8]
    )
    static func outOfBounds(tileCount: Int) {
        #expect(PDBHeuristic.Configuration(tileCount: tileCount) == nil)
    }
}
