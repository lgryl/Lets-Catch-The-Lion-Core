// Created 02/01/2021

import Foundation

class Elephant: GeneralPiece {
    override func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        guard startPoint != endPoint else { return false }
        return abs(endPoint.x - startPoint.x) == abs(endPoint.y - startPoint.y)
    }
}
