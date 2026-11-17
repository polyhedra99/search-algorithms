//
//  Formatting.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/18/26.
//

import Foundation

enum Formatting {
    static func elapsed(nanos: UInt64) -> String {
        let hours = Int(nanos / 3_600_000_000_000)
        let minutes = Int((nanos / 60_000_000_000) % 60)
        let seconds = Int((nanos / 1_000_000_000) % 60)
        let millis = Int((nanos / 1_000_000) % 1_000)

        return hours > 0
            ? String(format: "%d:%02d:%02d.%03d", hours, minutes, seconds, millis)
            : String(format: "%02d:%02d.%03d", minutes, seconds, millis)
    }

    static func number(_ value: Int) -> String {
        var sign = ""
        var digits = String(value)
        if digits.first == "-" {
            sign = "-"
            digits.removeFirst()
        }

        var grouped = ""
        grouped.reserveCapacity(digits.count + digits.count / 3)
        for (index, digit) in digits.enumerated() {
            if index > 0, (digits.count - index) % 3 == 0 {
                grouped.append("_")
            }
            grouped.append(digit)
        }
        return sign + grouped
    }

    static func throughput(_ throughputPerSecond: Double) -> String {
        let rounded = Int(throughputPerSecond.rounded())
        return "\(number(rounded)) states/s"
    }
}
