//
//  Sequence+NibblePacking.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/5/26.
//

public extension Sequence where Element == Int {
    var isNibblePackable: Bool {
        self.allSatisfy(NibblePacking.valueRange.contains(_:))
    }
}
