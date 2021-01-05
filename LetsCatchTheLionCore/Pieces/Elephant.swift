// Created 02/01/2021

import Foundation

class Elephant: GeneralPiece {
    func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        abs(endPoint.x - startPoint.x) == abs(endPoint.y - startPoint.y)
    }
}
