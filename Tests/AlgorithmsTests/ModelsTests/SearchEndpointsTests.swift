import Testing
@testable import CustomTags
@testable import Algorithms

@Suite("Search endpoints initialization", .tags(.initialization))
enum EndpointsInitializationTests {
    @Test("Distinct states", .tags(.success), arguments: [0xA, 0xB, 0xD])
    static func distinctStates(origin: UInt64) throws {
        let target: UInt64 = 0xC
        let endpoints = try #require(
            SearchEndpoints(origin: origin, target: target))
        
        #expect(endpoints.origin == origin)
        #expect(endpoints.target == target)
    }
    
    @Test("Equal states", .tags(.failure))
    static func equalStates() {
        #expect(SearchEndpoints(origin: 0xA, target: 0xA) == nil)
    }
}
