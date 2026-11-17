//
//  Matrix+Letters.swift
//  search-algorithms
//
//  Created by Mykhailo on 9/30/26.
//

import PuzzleRulesets

public extension Matrix where Element == Int {
    /// Maps each element to a `Letter`, preserving geometry.
    /// Returns `nil` when any element is outside `0...25`.
    func formattedAsLetters(
        letterCase: Letter.Case = .uppercase
    ) -> Matrix<Letter>? {
        let elements = self.elements
        
        let letters = elements.compactMap { int in
            return Letter(int, letterCase: letterCase)
        }
        guard elements.count == letters.count else { return nil }
        
        return Matrix<Letter>(
            elements: letters,
            dimensions: self.dimensions
        )
    }
}

public extension Array where Element == Matrix<Int> {
    /// Maps every matrix to `Letter`s, preserving geometry.
    /// Returns `nil` when any element of any matrix is outside `0...25`.
    func allFormattedAsLetters(
        letterCase: Letter.Case = .uppercase
    ) -> [Matrix<Letter>]? {
        let formatted = self.compactMap { matrix in
            matrix.formattedAsLetters(letterCase: letterCase)
        }
        
        guard formatted.count == self.count
        else { return nil }
        
        return formatted
    }
}
