// Created 16/01/2021

import Foundation

struct GiraffeMovementRules: MovementRules {
    func allowsMove(from startPosition: Position,
                    to endPosition: Position,
                    standardOrientation: Bool) -> Bool {
        (startPosition.x == endPosition.x && startPosition.y != endPosition.y) || (startPosition.x != endPosition.x && startPosition.y == endPosition.y)
    }
}
