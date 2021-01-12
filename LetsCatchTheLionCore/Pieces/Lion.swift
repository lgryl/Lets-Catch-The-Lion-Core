// Created 31/12/2020

import Foundation

class Lion: GeneralPiece {
    override func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        guard startPoint != endPoint else { return false }
        return abs(endPoint.x - startPoint.x) <= 1 && abs(endPoint.y - startPoint.y) <= 1
    }
}
