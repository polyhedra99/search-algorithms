//
//  String+Padding.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/1/26.
//

public extension String {
    /// Appends spaces until the string reaches `length`.
    /// A string of `length` or more is returned unchanged.
    func padded(toLength length: Int) -> String {
        guard self.count < length else { return self }
        
        return self + String(repeating: " ", count: length - count)
    }
}

public extension Array where Element == String {
    /// Maps every element through `padded(toLength:)`.
    func eachPadded(toLength length: Int) -> [String] {
        return self.map { $0.padded(toLength: length) }
    }
}
