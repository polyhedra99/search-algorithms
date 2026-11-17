//
//  Letter.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/2/26.
//

public struct Letter: CustomStringConvertible, Equatable {
    let scalar: Unicode.Scalar
    
    public var description: String {
        return String(scalar)
    }
    
    init?(_ int: Int, letterCase: Case) {
        guard let uint8 = UInt8(exactly: int),
              let scalar = letterCase.offsetFirst(by: uint8)
        else { return nil }
        
        self.scalar = scalar
    }
}

public extension Letter {
    enum Case: Sendable {
        case lowercase
        case uppercase
        
        var firstLetterCode: UInt8 {
            switch self {
            case .lowercase: return UInt8(ascii: "a")
            case .uppercase: return UInt8(ascii: "A")
            }
        }
        
        func offsetFirst(by offset: UInt8) -> Unicode.Scalar? {
            guard (0...25).contains(offset) else { return nil }
            return UnicodeScalar(firstLetterCode &+ offset)
        }
    }
}
