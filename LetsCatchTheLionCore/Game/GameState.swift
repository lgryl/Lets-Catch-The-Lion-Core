// Created 09/01/2021

import Foundation

public enum GameState {
    case ongoing(currentPlayer: PlayerType)
    case finished(winner: PlayerType)
}

extension GameState: Equatable {
    
}
