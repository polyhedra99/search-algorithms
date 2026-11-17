//
//  Matrix+Description.swift
//  search-algorithms
//
//  Created by Mykhailo on 9/30/26.
//

import Foundation
import PuzzleRulesets

public extension Matrix {
    /// Joins element descriptions into rows, padding each to the longest description.
    /// Returns an empty string when every description is empty.
    func described(
        separator: String = MatrixDefaults.elementSeparator
    ) -> String {
        let rows = self.representedAsRows()
        
        let rowsOfDescriptions = rows.map { row in
            return row.map(String.init(describing:))
        }
        let descriptions = rowsOfDescriptions.flatMap(\.self)
        
        let lengths = descriptions.map(\.count)
        let maxLength = lengths.max() ?? .zero
        guard maxLength > .zero else { return "" }
        
        let paddedRows = rowsOfDescriptions.map { rowOfDescriptions in
            let paddedRow = rowOfDescriptions.eachPadded(toLength: maxLength)
            return paddedRow.joined(separator: separator)
        }
        return paddedRows.joined(separator: "\n")
    }
}

public extension Array {
    /// Maps every element through `described(separator:)`.
    func eachDescribed<MatrixElement>(
        separator: String = MatrixDefaults.elementSeparator
    ) -> [String]
    where Element == Matrix<MatrixElement> {
        return self.map { $0.described(separator: separator) }
    }
}
