// Created 02/01/2021

import Foundation

class Chick: GeneralPiece {
    override func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        endPosition.y - startPosition.y == (defaultOrientation ? -1 : 1)
    }
}
