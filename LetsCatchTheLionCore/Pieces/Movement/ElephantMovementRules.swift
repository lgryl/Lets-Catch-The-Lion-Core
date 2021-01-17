// Created 16/01/2021

import Foundation

struct ElephantMovementRules: MovementRules {
    func allowsMove(from startPosition: Position,
                    to endPosition: Position,
                    standardOrientation: Bool) -> Bool {
        guard startPosition != endPosition else { return false }
        return abs(endPosition.x - startPosition.x) == abs(endPosition.y - startPosition.y)
    }
}
