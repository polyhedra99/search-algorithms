import Testing
@testable import CustomTags
@testable import PuzzleRulesets

@Suite("Matrix helpers", .tags(.behavior, .success))
enum MatrixHelpersTests {
    @Test("Row representation")
    static func rowRepresentation() {
        let rows: [[Int]] = [
            [1, 2, 3, 4],
            [5, 6, 7, 8]
        ]
        
        let dimensions = MatrixDimensions(
            rowCount: 2,
            columnCount: 4
        )
        
        let matrix = Matrix<Int>(
            elements: rows.flatMap(\.self),
            dimensions: dimensions
        )
        
        #expect(matrix.representedAsRows() == rows)
    }
    
    @Test("Elements replacement")
    static func elementsReplacement() throws {
        let originalElements: [Int] = Array(1...16)
        let newElements = originalElements.map(String.init(describing:))
        
        let dimensions = MatrixDimensions(
            rowCount: 4,
            columnCount: 4
        )
        
        let originalMatrix = Matrix(
            elements: originalElements,
            dimensions: dimensions
        )
        
        let newMatrix = try #require(
            originalMatrix.replacingElements(with: newElements)
        )
        
        #expect(newMatrix.elements == newElements)
    }
}
