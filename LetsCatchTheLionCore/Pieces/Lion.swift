// Created 31/12/2020

import Foundation

class Lion: GeneralPiece {
    func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        abs(endPoint.x - startPoint.x) <= 1 && abs(endPoint.y - startPoint.y) <= 1
    }
}
