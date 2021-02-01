// Created 16/01/2021

import Foundation

struct GiraffeMovementRules: MovementRules {
    func allowsMove(from startPosition: Position,
                    to endPosition: Position,
                    standardOrientation: Bool) -> Bool {
        abs(endPosition.x - startPosition.x) + abs(endPosition.y - startPosition.y) == 1
    }
}
