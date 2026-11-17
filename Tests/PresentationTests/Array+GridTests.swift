import Testing
@testable import CustomTags
@testable import Presentation

@Suite("Grid Layout")
enum GridLayoutTests {
    static let sampleArray: [Int] = [123, 456, 789]
    static let multilineSampleArray: [String] = [
        "123\n123", "456", "789\n789"
    ]

    static let rowSeparator: String = GridDefaults.rowSeparator
    static let columnSeparator: String = GridDefaults.columnSeparator
    
    @Suite("Initialization", .tags(.initialization, .failure))
    enum GridInitializationTests {
        @Test(
            "Empty input data",
            arguments: [[], ["", ""]]
        )
        static func emptyInputData(array: [String]) {
            let grid = array.describedInGrid()
            #expect(grid.isEmpty)
        }
    }
    
    @Suite("Sample Presentation", .tags(.behavior, .success))
    enum SamplePresentation {
        @Test("With overflow", arguments: [2])
        static func gridWithOverflow(maxColumnCount: Int) {
            let grid = sampleArray
                .describedInGrid(maxColumnCount: maxColumnCount)
            let expectation: String = """
                123\(columnSeparator)456\(rowSeparator)789
                """
            #expect(grid == expectation)
        }
        
        @Test("Without overflow", arguments: [3])
        static func gridWithoutOverflow(maxColumnCount: Int) {
            let grid = sampleArray
                .describedInGrid(maxColumnCount: maxColumnCount)
            let expectation: String = """
                123\(columnSeparator)456\(columnSeparator)789
                """
            #expect(grid == expectation)
        }
    }
    
    @Suite("Multiline Sample Presentation", .tags(.behavior, .success))
    enum MultilineSamplePresentation {
        @Test("With overflow", arguments: [2])
        static func gridWithOverflow(maxColumnCount: Int) {
            let grid = multilineSampleArray
                .describedInGrid(maxColumnCount: maxColumnCount)
            
            let firstSubrow: String = "123\(columnSeparator)456"
            let secondSubrow: String = "123\(columnSeparator)   "
            let thirdSubrow: String = "789"
            let fourthSubrow: String = "789"
            
            let expectation: String =
            [firstSubrow, secondSubrow].joined(separator: "\n")
            + rowSeparator
            + [thirdSubrow, fourthSubrow].joined(separator: "\n")
            
            #expect(grid == expectation)
        }
        
        @Test("Without overflow", arguments: [3])
        static func gridWithoutOverflow(maxColumnCount: Int) {
            let grid = multilineSampleArray
                .describedInGrid(maxColumnCount: maxColumnCount)
            
            let firstSubRow: String = "123\(columnSeparator)456\(columnSeparator)789"
            let secondSubRow: String = "123\(columnSeparator)   \(columnSeparator)789"
            
            let expectation: String = [firstSubRow, secondSubRow].joined(separator: "\n")

            #expect(grid == expectation)
        }
    }
}
