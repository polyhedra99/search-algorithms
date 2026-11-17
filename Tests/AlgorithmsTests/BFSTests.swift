import Testing
@testable import CustomTags
@testable import Algorithms

@Suite("BFS", .tags(.behavior, .success))
enum BFSTests {
    typealias State = BFS.State
    typealias Distance = BFS.Distance
    
    @Test("Distance calculation")
    static func distanceCalculation() {
        let states: [State] = [0xA, 0xB, 0xC, 0xD]
        let ranker: (State) -> Int = { states.firstIndex(of: $0) ?? .max }
        let forEachPredecessor: (State, (State) -> Void) -> Void = {
            switch $0 {
            case 0xA: $1(0xB)
            case 0xB: $1(0xC)
            case 0xC: $1(0xD)
            default: return
            }
        }
        
        let distances = BFS.distances(
            from: 0xA,
            tableSize: 5,
            ranker: ranker,
            forEachPredecessor: forEachPredecessor
        )
        
        #expect(distances == [0, 1, 2, 3, .max])
    }
}
