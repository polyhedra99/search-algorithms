//
//  PDBHeuristic+Configuration.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/12/26.
//

extension PDBHeuristic {
    enum Configuration: Sendable {
        case sixTiles
        case sevenTiles
        
        var patternSize: Int {
            switch self {
            case .sixTiles: 6
            case .sevenTiles: 7
            }
        }
        
        var stateCount: Int {
            switch self {
            case .sixTiles: 5_765_760
            case .sevenTiles: 57_657_600
            }
        }
        
        init?(tileCount: Int) {
            switch tileCount {
            case 6: self = .sixTiles
            case 7: self = .sevenTiles
            default: return nil
            }
        }
    }
}
