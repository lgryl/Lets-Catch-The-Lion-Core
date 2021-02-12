// Created 18/01/2021

import Foundation

public struct Position {
    var x: Int
    var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position: Equatable {}

extension Position: Hashable {}

extension Position: CustomStringConvertible {
    public var description: String {
        return "(x: \(x), y: \(y))"
    }
}
