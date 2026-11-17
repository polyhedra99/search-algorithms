//
//  Array+GridLayout.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/1/26.
//

public extension Array where Element: CustomStringConvertible {
    /// Joins descriptions into blocks of at most `maxColumnCount` columns,
    /// aligning multiline descriptions line-by-line.
    ///
    /// Returns an empty string when the array is empty,
    /// or when every description is empty.
    func describedInGrid(
        rowSeparator: String = GridDefaults.rowSeparator,
        columnSeparator: String = GridDefaults.columnSeparator,
        maxColumnCount: Int = 6
    ) -> String {
        precondition(maxColumnCount > 0)
        guard !self.isEmpty else { return "" }

        let descriptions = self.map(\.description)
        let blocks = descriptions.representedAsBlocks()
        
        let blockWidth = blocks.flatMap(\.self).map(\.count).max()!
        let blockHeight = blocks.map(\.count).max()!
        
        guard blockWidth > 0 else { return "" }
        
        let columnCount = Swift.min(self.count, maxColumnCount)
        let gridRowStarts = stride(from: 0, to: self.count, by: columnCount)
        
        let gridRows = gridRowStarts.map { gridRowStart in
            let gridRowEnd = Swift.min(self.count, gridRowStart + columnCount)
            let gridRowBlocks = blocks[gridRowStart..<gridRowEnd]
            
            let lines = (0..<blockHeight).map { lineIndex in
                let columns = gridRowBlocks.map { block in
                    let line: String
                    if lineIndex < block.count {
                        line = block[lineIndex]
                    } else {
                        line = ""
                    }
                    
                    return line.padded(toLength: blockWidth)
                }
                
                return columns.joined(separator: columnSeparator)
            }
            
            return lines.joined(separator: "\n")
        }
        
        return gridRows.joined(separator: rowSeparator)
    }
}

extension Array where Element == String {
    func representedAsBlocks() -> [[String]] {
        return self.map { string in
            let splits = string.split(
                separator: "\n",
                omittingEmptySubsequences: false
            )
               
            return splits.map(String.init)
        }
    }
}
