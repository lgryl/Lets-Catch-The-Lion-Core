// Created 02/01/2021

import Foundation

class Chick: GeneralPiece {
    override func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        endPoint.y - startPoint.y == (defaultOrientation ? -1 : 1)
    }
}
