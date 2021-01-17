// Created 16/01/2021

import Foundation

struct HenMovementRules: MovementRules {
    func allowsMove(from startPosition: Position, to endPosition: Position, standardOrientation: Bool) -> Bool {
        let dx = endPosition.x - startPosition.x
        let dy = endPosition.y - startPosition.y
        return (abs(dx) == 1 || abs(dy) == 1) && !(dy == (standardOrientation ? 1 : -1) && abs(dx) == 1)
    }
}
