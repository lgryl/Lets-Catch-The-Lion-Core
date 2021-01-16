// Created 31/12/2020

import Foundation

public protocol Piece: AnyObject {
    var owner: PlayerType { get set }
    func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool
}

public class GeneralPiece: Piece {
    public func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        false
    }

    public var owner: PlayerType
    init(owner: PlayerType) {
        self.owner = owner
    }
}

extension GeneralPiece {
    var defaultOrientation: Bool {
        owner == .player1
    }
}

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
