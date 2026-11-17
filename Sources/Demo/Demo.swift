// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Presentation
import PuzzleDomain
import PuzzleRulesets
import PuzzleSearch

@main
struct Demo {
    static func main() {
        guard let puzzle = Puzzle<Turntable2x5>(targetArray: Array(0...9))
        else { fatalError("Failed to make a puzzle.") }

        let origin = puzzle.makeShuffle(moveCount: 48)
        guard let endpoints = SearchEndpoints(origin: origin, target: puzzle.target)
        else { fatalError("Failed to make endpoints.") }

        let searchResult = BiBFS.search(
            endpoints: endpoints,
            expectedDiscoveries: 1_200_000,
            forEachSuccessor: puzzle.forEachSuccessor(of:yield:),
            forEachPredecessor: puzzle.forEachSuccessor(of:yield:)
        )

        describeSearchResult(
            puzzle: puzzle,
            endpoints: endpoints,
            searchResult: searchResult
        )
    }

    static func describeSearchResult<R: Nibble16Ruleset>(
        puzzle: Puzzle<R>,
        endpoints: SearchEndpoints,
        searchResult: BiBFS.SearchResult,
        emitDescription: (String) -> Void = { print($0) }
    ) {
        switch searchResult {
        case let .success(path):
            describeSuccess(
                puzzle: puzzle,
                path: path,
                emitDescription: emitDescription
            )
        case .failure:
            describeFailure(
                puzzle: puzzle,
                endpoints: endpoints,
                emitDescription: emitDescription
            )
        }
    }

    static func describeSuccess<R: Nibble16Ruleset>(
        puzzle: Puzzle<R>,
        path: [R.State],
        emitDescription: (String) -> Void
    ) {
        precondition(path.count >= 2)

        let matrices = path.map { puzzle.makeMatrix(from: $0) }
        let described = matrices.allFormattedAsLetters()?.eachDescribed()
            ?? matrices.eachDescribed()

        let endpointsDescriptions = [
            described.first!.labeled(with: "Origin"),
            described.last!.labeled(with: "Target")
        ]

        let pathDescriptions = described.enumerated().map { index, description in
            description.labeled(with: index == 0 ? "" : "#\(index)")
        }

        let endpointsGrid = endpointsDescriptions.describedInGrid()
        let pathGrid = pathDescriptions.describedInGrid()
        
        emitDescription(endpointsGrid.underlined() + "\n" + pathGrid)
    }

    static func describeFailure<R: Nibble16Ruleset>(
        puzzle: Puzzle<R>,
        endpoints: SearchEndpoints,
        emitDescription: (String) -> Void
    ) {
        let matrices = [endpoints.origin, endpoints.target]
            .map { puzzle.makeMatrix(from: $0) }
        
        let described = matrices.allFormattedAsLetters()?.eachDescribed()
            ?? matrices.eachDescribed()

        emitDescription(described.describedInGrid() + "\nSearch resulted in failure.")
    }
}
