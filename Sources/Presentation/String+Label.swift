//
//  String+Label.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/2/26.
//

public extension String {
    /// Prepends `label`, `terminator` and `separator` to description.
    /// Prepends only `separator` when label is empty.
    func labeled(
        with label: String,
        terminator: String = LabelDefaults.terminator,
        separator: String = LabelDefaults.separator
    ) -> String {
        guard !label.isEmpty else { return separator + self }

        return label + terminator + separator + self
    }
}

public extension Array where Element == String {
    /// Maps every element through `labeled(with:terminator:separator:)`.
    /// Returns `nil` when the label count differs from the description count.
    func allLabeled(
        with labels: [String],
        terminator: String = LabelDefaults.terminator,
        separator: String = LabelDefaults.separator
    ) -> [String]? {
        guard count == labels.count else { return nil }

        return zip(self, labels).map { string, label in
            string.labeled(
                with: label,
                terminator: terminator,
                separator: separator
            )
        }
    }
}
