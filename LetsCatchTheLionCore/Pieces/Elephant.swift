// Created 02/01/2021

import Foundation

class Elephant: GeneralPiece {
    override func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        guard startPosition != endPosition else { return false }
        return abs(endPosition.x - startPosition.x) == abs(endPosition.y - startPosition.y)
    }
}
