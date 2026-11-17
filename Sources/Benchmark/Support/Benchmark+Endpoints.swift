//
//  Benchmark+Endpoints.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/8/26.
//

import Algorithms
import PuzzleDomain
import PuzzleRulesets

extension Benchmark {
    static func makeEndpoints<R: Nibble16Ruleset>(
        for puzzle: Puzzle<R>,
        count: Int,
        shuffleMoveCount: Int = 64
    ) -> [SearchEndpoints] {
        return (0..<count).map { _ in
            var origin = puzzle.target
            repeat {
                origin = puzzle.makeShuffle(moveCount: shuffleMoveCount)
            } while origin == puzzle.target
            
            guard let endpoints = SearchEndpoints(
                origin: origin,
                target: puzzle.target
            ) else { fatalError("Failed to make endpoints.") }
            
            return endpoints
        }
    }
}
