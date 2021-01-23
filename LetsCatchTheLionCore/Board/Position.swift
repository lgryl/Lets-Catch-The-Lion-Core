// Created 18/01/2021

import Foundation

public struct Position {
    var x: Int
    var y: Int
}

extension Position: Equatable {}

extension Position: CustomStringConvertible {
    public var description: String {
        return "x: \(x), y: \(y)"
    }
}
