// Created 02/01/2021

import Foundation

class Giraffe: GeneralPiece {
    override func allowsMove(from startPosition: Position, to endPosition: Position) -> Bool {
        (startPosition.x == endPosition.x && startPosition.y != endPosition.y) || (startPosition.x != endPosition.x && startPosition.y == endPosition.y)
    }
}
