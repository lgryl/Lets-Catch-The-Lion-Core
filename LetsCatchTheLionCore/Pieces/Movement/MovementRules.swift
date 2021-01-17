// Created 16/01/2021

import Foundation

protocol MovementRules {
    func allowsMove(from startPosition: Position,
                    to endPosition: Position,
                    standardOrientation: Bool) -> Bool
}
