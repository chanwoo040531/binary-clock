//
//  ColorOption.swift
//  BinaryClock
//
//  Created by 김찬우 on 11/6/23.
//

import Foundation

enum ColorOption {
    case background
    case bit
    
    func value() -> String {
        switch self {
        case .background:
            return "BACKGROUND"
        case .bit:
            return "BIT"
        }
    }
}
