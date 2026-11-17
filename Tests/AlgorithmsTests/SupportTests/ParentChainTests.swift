import Testing
@testable import CustomTags
@testable import Algorithms

@Suite("Parent chain", .tags(.behavior, .success))
enum ParentChainTests {
    typealias State = ParentChain.State
    
    @Test("Predefined walk")
    static func predefinedWalk() {
        let parents: [State: State] = [0xA: 0xB, 0xB: 0xC, 0xC: 0xD]
        let path = ParentChain.walk(descendant: 0xA, root: 0xD, parents: parents)
        
        #expect(path == [0xA, 0xB, 0xC, 0xD])
    }
}
