//
//  Benchmark+Report.swift
//  search-algorithms
//
//  Created by Mykhailo on 11/8/26.
//

import Presentation

extension Benchmark {
    static func makePDBReport(timeElapsed: UInt64) -> String {
        let time = Formatting.elapsed(nanos: timeElapsed)
        return """
            PDB construction finished
            Time elapsed: \(time)
            """
    }
    
    static func makeHeuristicReport(
        evaluations: [HeuristicEvaluation]
    ) -> String {
        let gridEntries: [String] = evaluations.map {
            let percentage = Int($0.averageStrength * 100)
            return "\(percentage)%".labeled(with: String($0.depth))
        }
        
        return """
            Heuristic strength evaluation per depth:
            \(gridEntries.describedInGrid(maxColumnCount: 8))
            """
    }
    
    static func makeValidationReport(
        paths: [[State]?],
        oracle: [[State]?]
    ) -> String {
        let correct: Int = zip(paths, oracle).reduce(0) {
            return $1.0?.count == $1.1?.count ? $0 + 1 : $0
        }
        
        return """
            Optimality validation:
            \(correct)/\(oracle.count) correct
            """
    }
    
    static func makeRunReport(
        from metrics: [BiBFSMetrics],
        ruleset: String
    ) -> String {
        return makeRunReport(
            from: metrics.map(\.metrics),
            algorithm: "BiBFS",
            ruleset: ruleset
        )
    }
    
    static func makeRunReport(
        from metrics: [AStarMetrics],
        ruleset: String
    ) -> String {
        return makeRunReport(
            from: metrics.map(\.metrics),
            algorithm: "A*",
            ruleset: ruleset
        )
    }
}

fileprivate extension Benchmark {
    static func makeRunReport(
        from metrics: [Metrics],
        algorithm: String,
        ruleset: String
    ) -> String {
        let runs = metrics.count
        
        let times: [UInt64] = metrics.map(\.timeElapsed)
        let discoveries: [Int] = metrics.map(\.statesDiscovered)
        let expansions: [Int] = metrics.map(\.statesExpanded)
        let throughputsPerSecond: [Double] = metrics.compactMap {
            guard $0.timeElapsed > 0 else { return nil }
            
            let secondsElapsed: Double = Double($0.timeElapsed) / 1_000_000_000.0
            return Double($0.statesDiscovered) / secondsElapsed
        }
        let pathLengths: [Int] = metrics.compactMap(\.path?.count)
        
        let minTime: String = Formatting.elapsed(nanos: times.min()!)
        let maxTime: String = Formatting.elapsed(nanos: times.max()!)
        let avgTime: String = Formatting.elapsed(nanos: times.reduce(0, +) / UInt64(runs))
        
        let minDiscovered: String = Formatting.number(discoveries.min()!)
        let maxDiscovered: String = Formatting.number(discoveries.max()!)
        let avgDiscovered: String = Formatting.number(discoveries.reduce(0, +) / runs)
        
        let minExpanded: String = Formatting.number(expansions.min()!)
        let maxExpanded: String = Formatting.number(expansions.max()!)
        let avgExpanded: String = Formatting.number(expansions.reduce(0, +) / runs)
        
        let minThroughput: String
        let maxThroughput: String
        let avgThroughput: String
        
        let minLength: String
        let maxLength: String
        let avgLength: String
        
        if let minRawThroughput = throughputsPerSecond.min(),
           let maxRawThroughput = throughputsPerSecond.max() {
            minThroughput = Formatting.throughput(minRawThroughput)
            maxThroughput = Formatting.throughput(maxRawThroughput)
            
            let avgRawThroughput = throughputsPerSecond.reduce(0, +) / Double(runs)
            avgThroughput = Formatting.throughput(avgRawThroughput)
        } else {
            minThroughput = FormattingDefaults.notAvailable
            maxThroughput = FormattingDefaults.notAvailable
            avgThroughput = FormattingDefaults.notAvailable
        }
        
        if let minRawLength = pathLengths.min(),
           let maxRawLength = pathLengths.max() {
            minLength = Formatting.number(minRawLength)
            maxLength = Formatting.number(maxRawLength)
            avgLength = Formatting.number(pathLengths.reduce(0, +) / runs)
        } else {
            minLength = FormattingDefaults.notAvailable
            maxLength = FormattingDefaults.notAvailable
            avgLength = FormattingDefaults.notAvailable
        }
        
        let successes = pathLengths.count
        
        return """
            Algorithm: \(algorithm)
            Ruleset: \(ruleset)
            Runs: \(runs)
            Time elapsed during Main Phase:
                Min: \(minTime)
                Max: \(maxTime)
                Avg: \(avgTime)
            States discovered:
                Min: \(minDiscovered)
                Max: \(maxDiscovered)
                Avg: \(avgDiscovered)
            States expanded:
                Min: \(minExpanded)
                Max: \(maxExpanded)
                Avg: \(avgExpanded)
            Discovery throughput:
                Min: \(minThroughput)
                Max: \(maxThroughput)
                Avg: \(avgThroughput)
            Path length:
                Min: \(minLength)
                Max: \(maxLength)
                Avg: \(avgLength)
            Results:
                Success: \(successes) out of \(runs)
            """
    }
}
