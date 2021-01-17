// Created 16/01/2021

import Foundation

public enum PlayerType {
    case player1
    case player2

    var next: Self {
        switch self {
        case .player1:
            return .player2
        case .player2:
            return .player1
        }
    }
}
