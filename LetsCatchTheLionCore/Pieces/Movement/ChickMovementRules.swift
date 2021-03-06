// Created 16/01/2021

import Foundation

struct ChickMovementRules: MovementRules {
    func allowsMove(from startPosition: Position,
                    to endPosition: Position,
                    standardOrientation: Bool) -> Bool {
        startPosition.x == endPosition.x && endPosition.y - startPosition.y == (standardOrientation ? -1 : 1)
    }
}
