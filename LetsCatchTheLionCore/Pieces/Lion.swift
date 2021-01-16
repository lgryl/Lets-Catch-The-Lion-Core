// Created 31/12/2020

import Foundation

class Lion: GeneralPiece {
    override func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        guard startPosition != endPosition else { return false }
        return abs(endPosition.x - startPosition.x) <= 1 && abs(endPosition.y - startPosition.y) <= 1
    }
}
