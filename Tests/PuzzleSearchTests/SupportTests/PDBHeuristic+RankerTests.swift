import Testing
import NibblePacking
@testable import CustomTags
@testable import PuzzleSearch

@Suite("PDB Heuristic Ranker", .tags(.behavior, .success))
enum RankerTests {
    @Test(
        "Hand-picked for [2, 4, 6, 10, 12, 14]",
        arguments: [
            (array: Array(0...15),
             expectedRank: 800_677), // 2*360_360 + 3*24_024 + 4*1_716 + 7*132 + 8*11 + 9*1
            (array: Array(0...15).reversed(),
             expectedRank: 4_965_082), // 13*360_360 + 11*24_024 + 9*1_716 + 5*132 + 3*11 + 1*1
            (array: [2, 4, 6, 10, 12, 14, 0, 1, 3, 5, 7, 8, 9, 11, 13, 15],
             expectedRank: 0), // 0*360_360 + 0*24_024 + 0*1_716 + 5*132 + 3*11 + 1*1
            (array: [0, 1, 3, 5, 7, 8, 9, 11, 13, 15, 2, 4, 6, 10, 12, 14],
             expectedRank: 3_862_440), // 10*360_360 + 10*24_024 + 10*1_716 + 10*132 + 10*11 + 10*1
            (array: [3, 14, 7, 2, 11, 6, 0, 10, 1, 4, 13, 12, 5, 8, 15, 9],
             expectedRank: 1_280_874), // 3*360_360 + 8*24_024 + 4*1_716 + 5*132 + 7*11 + 1*1
            (array: [8, 0, 12, 5, 2, 9, 14, 1, 6, 3, 10, 7, 4, 11, 13, 15],
             expectedRank: 1_718_798) // 4*360_360 + 11*24_024 + 7*1_716 + 8*132 + 2*11 + 4*1
        ]
    )
    static func handpickedSixTileArrays(array: [Int], expectedRank: Int) throws {
        let target = try #require(
            PDBHeuristic.Target(Array(0...15)))
        let pattern = try #require(
            PDBHeuristic.Pattern(target: target, tileSet: [2, 4, 6, 10, 12, 14]))
        
        let ranker = PDBHeuristic.Ranker(pattern: pattern)
        let positions = PDBHeuristic.extractPositions(from: UInt64(nibbles: array))
        
        #expect(ranker.rank(positions: positions) == expectedRank)
    }
    
    @Test(
        "Hand-picked for [2, 4, 6, 8, 10, 12, 14]",
        arguments: [
            (array: Array(0...15),
             expectedRank: 8_003_898), // 2*3_603_600 + 3*240_240 + 4*17_160 + 5*1_320 + 6*110 + 7*10 + 8*1
            (array: Array(0...15).reversed(),
             expectedRank: 49_653_701), // 13*3_603_600 + 11*240_240 + 9*17_160 + 7*1_320 + 5*110 + 3*10 + 1*1
            (array: [2, 4, 6, 10, 12, 14, 0, 1, 3, 5, 7, 8, 9, 11, 13, 15],
             expectedRank: 10_560), // 0*3_603_600 + 0*240_240 + 0*17_160 + 8*1_320 + 0*110 + 0*10 + 0*1
            (array: [0, 1, 3, 5, 7, 8, 9, 11, 13, 15, 2, 4, 6, 10, 12, 14],
             expectedRank: 38_617_689), // 10*3_603_600 + 10*240_240 + 10*17_160 + 5*1_320 + 9*110 + 9*10 + 9*1
            (array: [3, 14, 7, 2, 11, 6, 0, 10, 1, 4, 13, 12, 5, 8, 15, 9],
             expectedRank: 12_815_181), // 3*3_603_600 + 8*240_240 + 4*17_160 + 10*1_320 + 5*110 + 7*10 + 1*1
            (array: [8, 0, 12, 5, 2, 9, 14, 1, 6, 3, 10, 7, 4, 11, 13, 15],
             expectedRank: 17_177_943) // 4*3_603_600 + 11*240_240 + 7*17_160 + 0*1_320 + 7*110 + 1*10 + 3*1
        ]
    )
    static func handpickedSevenTileArrays(array: [Int], expectedRank: Int) throws {
        let target = try #require(
            PDBHeuristic.Target(Array(0...15)))
        let pattern = try #require(
            PDBHeuristic.Pattern(target: target, tileSet: [2, 4, 6, 8, 10, 12, 14]))
        
        let ranker = PDBHeuristic.Ranker(pattern: pattern)
        let positions = PDBHeuristic.extractPositions(from: UInt64(nibbles: array))
        
        #expect(ranker.rank(positions: positions) == expectedRank)
    }
}
