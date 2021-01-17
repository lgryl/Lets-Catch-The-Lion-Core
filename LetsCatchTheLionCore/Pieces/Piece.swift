// Created 31/12/2020

import Foundation

public class Piece {
    private(set) var type: PieceType
    var owner: PlayerType

    init(_ type: PieceType, owner: PlayerType) {
        self.owner = owner
        self.type = type
    }

    public func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        type.movementRules.allowsMove(from: startPosition, to: endPosition, standardOrientation: standardOrientation)
    }

    public func powerUp() {
        type.powerUp()
    }

    public func powerDown() {
        type.powerDown()
    }
}

extension Piece {
    var standardOrientation: Bool {
        owner == .player1
    }
}
