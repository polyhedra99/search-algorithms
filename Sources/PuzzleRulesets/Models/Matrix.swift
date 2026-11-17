//
//  Matrix.swift
//  search-algorithms
//
//  Created by Mykhailo on 9/28/26.
//

public struct Matrix<Element> {
    public let elements: [Element]
    public let dimensions: MatrixDimensions
    
    public init(
        elements: [Element],
        dimensions: MatrixDimensions
    ) {
        precondition(elements.count == dimensions.cellCount)
        
        self.elements = elements
        self.dimensions = dimensions
    }
}

public struct MatrixDimensions: Equatable, Sendable {
    public let rowCount: Int
    public let columnCount: Int
    
    public var cellCount: Int {
        return self.rowCount * self.columnCount
    }
    
    public init(rowCount: Int, columnCount: Int) {
        precondition(rowCount > 0)
        precondition(columnCount > 0)
        
        self.rowCount = rowCount
        self.columnCount = columnCount
    }
}

public extension Matrix {
    /// Returns elements grouped into rows of `dimensions.columnCount`,
    /// in row-major order.
    /// Never fails: dimensions guarantee divisibility.
    func representedAsRows() -> [[Element]] {
        let elementCount = self.elements.count
        let columnCount = self.dimensions.columnCount
        
        let rowStarts = stride(from: 0, to: elementCount, by: columnCount)
        
        return rowStarts.map { rowStart in
            let rowEnd = rowStart + columnCount
            return Array(self.elements[rowStart..<rowEnd])
        }
    }
    
    /// Returns a matrix with the same dimensions and new elements.
    /// Returns `nil` when `newElements.count`differs from `dimensions.cellCount`.
    func replacingElements<NewElement>(
        with newElements: [NewElement]
    ) -> Matrix<NewElement>? {
        guard newElements.count == self.dimensions.cellCount
        else { return nil }
        
        return Matrix<NewElement>(
            elements: newElements,
            dimensions: self.dimensions
        )
    }
}
