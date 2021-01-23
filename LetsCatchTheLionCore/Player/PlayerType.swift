// Created 16/01/2021

import Foundation

public enum PlayerType: String {
    case ground
    case sky

    var next: Self {
        switch self {
        case .ground:
            return .sky
        case .sky:
            return .ground
        }
    }
}
