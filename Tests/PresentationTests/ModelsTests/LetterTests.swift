import Testing
@testable import CustomTags
@testable import Presentation

@Suite("Letter initialization", .tags(.initialization))
enum LetterInitializationTests {
    static let allLetterIndices: [Int] = Array(0...25)
    static let allLetterCases: [Letter.Case] = [
        Letter.Case.lowercase,
        Letter.Case.uppercase
    ]
    
    @Test(
        "All valid Ints to Letters",
        .tags(.success),
        arguments: allLetterIndices, allLetterCases
    )
    static func allValidInts(letterIndex: Int, letterCase: Letter.Case) throws {
        let letter = try #require(letterIndex.mappedToLetter(in: letterCase))
        
        let firstAscii: UInt8
        switch letterCase {
        case .lowercase: firstAscii = UInt8(ascii: "a")
        case .uppercase: firstAscii = UInt8(ascii: "A")
        }
        let scalar = UnicodeScalar(firstAscii &+ UInt8(letterIndex))
        
        #expect(letter.scalar == scalar)
        #expect(letter.description == String(scalar))
    }
    
    @Test(
        "Out of bounds",
        .tags(.failure),
        arguments: [Int.min, -1, 26, Int.max], allLetterCases
    )
    static func outOfBounds(letterIndex: Int, letterCase: Letter.Case) {
        let letter = letterIndex.mappedToLetter(in: letterCase)
        #expect(letter == nil)
    }
}

fileprivate extension Int {
    func mappedToLetter(in letterCase: Letter.Case) -> Letter? {
        return Letter(self, letterCase: letterCase)
    }
}
