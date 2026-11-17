//
//  UInt64+NibblePacking.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

public extension UInt64 {
    static let maxNibbleCount: Int = 16
    
    init(nibbles: [Int]) {
        precondition(nibbles.isNibblePackable)
        precondition(nibbles.count <= Self.maxNibbleCount)
        
        self = nibbles.enumerated().reduce(Self(0)) {
            $0 | Self($1.1) << ($1.0 * 4)
        }
    }
    
    func unpackNibbles(count: Int) -> [Int] {
        precondition(count <= Self.maxNibbleCount)
        
        return (0..<count).map { Int(self >> ($0 * 4) & 0xF) }
    }
    
    static func filledWith(nibble: Int) -> Self {
        precondition(NibblePacking.valueRange.contains(nibble))
        
        var filled = Self(nibble)
        filled |= filled << 4
        filled |= filled << 8
        filled |= filled << 16
        filled |= filled << 32
        
        return filled
    }
}
