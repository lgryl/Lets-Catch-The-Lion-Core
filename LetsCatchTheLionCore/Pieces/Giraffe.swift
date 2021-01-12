// Created 02/01/2021

import Foundation

class Giraffe: GeneralPiece {
    override func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        (startPoint.x == endPoint.x && startPoint.y != endPoint.y) || (startPoint.x != endPoint.x && startPoint.y == endPoint.y)
    }
}
