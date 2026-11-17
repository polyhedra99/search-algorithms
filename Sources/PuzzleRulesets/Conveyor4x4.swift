//
//  Conveyor4x4.swift
//  search-algorithms
//
//  Created by Mykhailo on 10/14/26.
//

import PuzzleDomain

public enum Conveyor4x4: Nibble16Ruleset {
    public enum Move: CaseIterable, ConveyorMove, Sendable {
        case left1, right1
        case left2, right2
        case left3, right3
        case left4, right4
        
        case up1, down1
        case up2, down2
        case up3, down3
        case up4, down4
    }
    
    public static let dimensions = MatrixDimensions(
        rowCount: 4,
        columnCount: 4
    )
}

public extension Conveyor4x4.Move {
    var mask: UInt64 {
        return switch self {
        case .left1, .right1: 0x0000_0000_0000_FFFF
        case .left2, .right2: 0x0000_0000_FFFF_0000
        case .left3, .right3: 0x0000_FFFF_0000_0000
        case .left4, .right4: 0xFFFF_0000_0000_0000
            
        case .up1, .down1: 0x000F_000F_000F_000F
        case .up2, .down2: 0x00F0_00F0_00F0_00F0
        case .up3, .down3: 0x0F00_0F00_0F00_0F00
        case .up4, .down4: 0xF000_F000_F000_F000
        }
    }
    
    var shifts: (wrap: Int, linear: Int) {
        return switch self {
        case .left1, .left2, .left3, .left4: (wrap: 12, linear: 4)
        case .right1, .right2, .right3, .right4: (wrap: 4, linear: 12)
            
        case .up1, .up2, .up3, .up4: (wrap: 48, linear: 16)
        case .down1, .down2, .down3, .down4: (wrap: 16, linear: 48)
        }
    }
}
