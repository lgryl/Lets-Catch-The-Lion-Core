// Created 31/12/2020

import Foundation

public protocol Piece {
    var owner: PlayerType { get }
    func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool
}

public class GeneralPiece: Piece {
    public var owner: PlayerType
    init(owner: PlayerType) {
        self.owner = owner
    }

}

extension Piece {
    public func allowsMove(from startPoint: Point, to endPoint: Point) -> Bool {
        false
    }
}

extension GeneralPiece {
    var defaultOrientation: Bool {
        owner == .player1
    }
}

public enum PlayerType {
    case player1
    case player2

    mutating func advance() {
        switch self {
        case .player1:
            self = .player2
        case .player2:
            self = .player1
        }
    }
}
