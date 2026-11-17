//
//  String+Underline.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/2/26.
//

public extension String {
    /// Appends a line of `character` matching the length of the last line.
    /// The input is taken verbatim: a trailing newline produces an empty underline, by design.
    func underlined(
        with character: Character = SpecialCharacters.overline
    ) -> String {
        let lines = self.split(
            separator: "\n",
            omittingEmptySubsequences: false
        )
        
        guard let lastLine = lines.last
        else { return self }
        
        let underline = String(
            repeating: character,
            count: lastLine.count
        )
        return self + "\n" + underline
    }
}

public extension Array where Element == String {
    /// Maps every element through `underlined(with:)`.
    func eachUnderlined(
        with character: Character = SpecialCharacters.overline
    ) -> [String] {
        return self.map { $0.underlined(with: character) }
    }
}
