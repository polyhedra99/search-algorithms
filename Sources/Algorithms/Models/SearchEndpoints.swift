//
//  SearchEndpoints.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/16/26.
//

public struct SearchEndpoints {
    public typealias State = UInt64
    
    public let origin: State
    public let target: State
    
    public init?(origin: State, target: State) {
        guard origin != target
        else { return nil }
        
        self.origin = origin
        self.target = target
    }
}
