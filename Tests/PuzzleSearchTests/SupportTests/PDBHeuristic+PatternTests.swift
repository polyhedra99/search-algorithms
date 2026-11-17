import Testing
import NibblePacking
@testable import CustomTags
@testable import PuzzleSearch

@Suite("PDB Heuristic Pattern")
enum PatternTests {
    @Suite("Initialization", .tags(.initialization))
    enum InitializationTests {
        @Test(
            "6-tile initialization",
            .tags(.success),
            arguments: [
                (tileSet: Set([0, 1, 2, 13, 14, 15]), sentinel: 3),
                (tileSet: Set([1, 2, 3, 4, 5, 6]), sentinel: 0)
            ]
        )
        static func sixTiles(tileSet: Set<Int>, sentinel: Int) throws {
            let pattern = try #require(makeCanonicalPattern(for: tileSet))
            let sentinels = UInt64.filledWith(nibble: sentinel)
            
            #expect(pattern.trackedTiles == tileSet.sorted())
            #expect(pattern.sentinels == sentinels)
        }
        
        @Test(
            "7-tile initialization",
            .tags(.success),
            arguments: [
                (tileSet: Set([0, 1, 2, 3, 13, 14, 15]), sentinel: 4),
                (tileSet: Set([1, 2, 3, 4, 5, 6, 7]), sentinel: 0)
            ]
        )
        static func sevenTiles(tileSet: Set<Int>, sentinel: Int) throws {
            let pattern = try #require(makeCanonicalPattern(for: tileSet))
            let sentinels = UInt64.filledWith(nibble: sentinel)
            
            #expect(pattern.trackedTiles == tileSet.sorted())
            #expect(pattern.sentinels == sentinels)
        }
        
        @Test(
            "Out of bounds k",
            .tags(.failure),
            arguments: [Set(0...4), Set(0...7)]
        )
        static func outOfBoundsK(tileSet: Set<Int>) {
            #expect(makeCanonicalPattern(for: tileSet) == nil)
        }
    }
    
    @Suite("Masking", .tags(.behavior, .success))
    enum MaskingTests {
        @Test(
            "Masking against tiles [2, 4, 6, 10, 12, 14]",
            arguments: [
                (array: Array(0...15),
                 expectedMask: UInt64(0x0E0C_0A00_0604_0200)),
                (array: Array(0...15).reversed(),
                 expectedMask: UInt64(0x0020_4060_00A0_C0E0)),
                (array: [2, 4, 6, 10, 12, 14, 0, 1, 3, 5, 7, 8, 9, 11, 13, 15],
                 expectedMask: UInt64(0x0000_0000_00EC_A642)),
                (array: [0, 1, 3, 5, 7, 8, 9, 11, 13, 15, 2, 4, 6, 10, 12, 14],
                 expectedMask: UInt64(0xECA6_4200_0000_0000)),
                (array: [3, 14, 7, 2, 11, 6, 0, 10, 1, 4, 13, 12, 5, 8, 15, 9],
                 expectedMask: UInt64(0x0000_C040_A060_20E0)),
                (array: [8, 0, 12, 5, 2, 9, 14, 1, 6, 3, 10, 7, 4, 11, 13, 15],
                 expectedMask: UInt64(0x0004_0A06_0E02_0C00))
            ]
        )
        static func maskinSixTiles(array: [Int], expectedMask: UInt64) throws {
            let tileSet: Set<Int> = [2, 4, 6, 10, 12, 14]
            let pattern = try #require(makeCanonicalPattern(for: tileSet))
            let state = UInt64(nibbles: array)
            
            #expect(pattern.masking(state) == expectedMask)
        }
        
        @Test(
            "Masking against tiles [2, 4, 6, 8, 10, 12, 14]",
            arguments: [
                (array: Array(0...15),
                 expectedMask: UInt64(0x0E0C_0A08_0604_0200)),
                (array: Array(0...15).reversed(),
                 expectedMask: UInt64(0x0020_4060_80A0_C0E0)),
                (array: [2, 4, 6, 8, 10, 12, 14, 0, 1, 3, 5, 7, 9, 11, 13, 15],
                 expectedMask: UInt64(0x0000_0000_0ECA_8642)),
                (array: [0, 1, 3, 5, 7, 9, 11, 13, 15, 2, 4, 6, 8, 10, 12, 14],
                 expectedMask: UInt64(0xECA8_6420_0000_0000)),
                (array: [3, 14, 7, 2, 11, 6, 0, 10, 1, 4, 13, 12, 5, 8, 15, 9],
                 expectedMask: UInt64(0x0080_C040_A060_20E0)),
                (array: [8, 0, 12, 5, 2, 9, 14, 1, 6, 3, 10, 7, 4, 11, 13, 15],
                 expectedMask: UInt64(0x0004_0A06_0E02_0C08))
            ]
        )
        static func maskingSevenTiles(array: [Int], expectedMask: UInt64) throws {
            let tileSet: Set<Int> = [2, 4, 6, 8, 10, 12, 14]
            let pattern = try #require(makeCanonicalPattern(for: tileSet))
            let state = UInt64(nibbles: array)
            
            #expect(pattern.masking(state) == expectedMask)
        }
    }
}

fileprivate func makeCanonicalPattern(
    for tileSet: Set<Int>
) -> PDBHeuristic.Pattern? {
    let targetArray: [Int] = Array(0...15)
    let target = PDBHeuristic.Target(targetArray)!
    
    return PDBHeuristic.Pattern(target: target, tileSet: tileSet)
}
