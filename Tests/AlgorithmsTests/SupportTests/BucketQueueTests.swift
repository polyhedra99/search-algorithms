import Testing
@testable import CustomTags
@testable import Algorithms

@Suite("Bucket Queue", .tags(.behavior, .success))
enum BucketQueueTests {
    typealias Entry = BucketQueue.Entry
    
    @Test("Predefined operations")
    static func predefinedOperations() throws {
        let e1 = Entry(state: 0xA, fValue: 2, gValue: 1)
        let e2 = Entry(state: 0xB, fValue: 2, gValue: 5)
        let e3 = Entry(state: 0xC, fValue: 7, gValue: 0)
        var bucketQueue: BucketQueue = [e1, e2, e3]
        
        #expect(bucketQueue.pop() == e2)
        
        let e4 = Entry(state: 0xD, fValue: 2, gValue: 3)
        let e5 = Entry(state: 0xE, fValue: 4, gValue: 9)
        bucketQueue.push(e4)
        bucketQueue.push(e5)
        
        #expect(bucketQueue.pop() == e4)
        #expect(bucketQueue.pop() == e1)
        #expect(bucketQueue.pop() == e5)
        #expect(bucketQueue.pop() == e3)
        #expect(bucketQueue.pop() == nil)
        #expect(bucketQueue.isEmpty)
    }
}
