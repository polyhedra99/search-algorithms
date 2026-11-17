//
//  BucketQueue.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/7/26.
//

import HeapModule

struct BucketQueue: ExpressibleByArrayLiteral {
    typealias State = UInt64
    typealias F = UInt8
    typealias G = UInt8
    
    private var buckets: [Heap<Entry>]
    private var cursor: F = 0
    private var liveCount: Int = 0
    
    var isEmpty: Bool { liveCount == 0 }
    
    static let totalBucketCount: Int = Int(F.max) + 1
    
    init(arrayLiteral elements: Entry...) {
        var buckets: [Heap<Entry>] = Array(
            repeating: [],
            count: Self.totalBucketCount
        )
        
        for element in elements {
            buckets[Int(element.fValue)].insert(element)
        }
        
        self.buckets = buckets
        self.liveCount = elements.count
    }
    
    mutating func push(_ entry: Entry) {
        assert(entry.fValue >= cursor)
        
        buckets[Int(entry.fValue)].insert(entry)
        liveCount += 1
    }
    
    mutating func pop() -> Entry? {
        while cursor < F.max && buckets[Int(cursor)].isEmpty {
            cursor &+= 1
        }
        
        guard let entry = buckets[Int(cursor)].popMax()
        else { return nil }
        
        liveCount -= 1
        return entry
    }
}

extension BucketQueue {
    struct Entry: Comparable {
        let state: State
        let fValue: F
        let gValue: G
        
        static func < (lhs: Entry, rhs: Entry) -> Bool {
            return lhs.gValue < rhs.gValue
        }
    }
}
