//
//  Nibble16Ruleset.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/14/26.
//

import NibblePacking
import PuzzleDomain

public protocol Nibble16Ruleset: Ruleset where State == UInt64 {
    static var dimensions: MatrixDimensions { get }
}

public extension Nibble16Ruleset {
    static func makeState(from array: [Int]) -> State? {
        guard array.count == dimensions.cellCount,
              array.isNibblePackable
        else { return nil }
        
        return State(nibbles: array)
    }
    
    static func makeMatrix(from state: State) -> Matrix<Int> {
        let count = dimensions.cellCount
        let elements = state.unpackNibbles(count: count)
        
        return Matrix<Int>(
            elements: elements,
            dimensions: dimensions
        )
    }
}

public extension Puzzle where R: Nibble16Ruleset {
    var targetElements: [Int] {
        self.makeMatrix(from: self.target).elements
    }
    
    init?(targetArray array: [Int]) {
        guard let state = R.makeState(from: array)
        else { return nil }
        
        self.init(target: state)
    }
    
    func makeMatrix(from state: R.State) -> Matrix<Int> {
        return R.makeMatrix(from: state)
    }
}
