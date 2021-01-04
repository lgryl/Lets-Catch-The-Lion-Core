// Created 31/12/2020

import Foundation

public protocol PiecesArrangement {
    var width: Int { get }
    var height: Int { get }
    func squareContentAt(x: Int, y: Int) -> SquareContent
}

public enum SquareContent {
    case none
    case player1(Piece)
    case player2(Piece)
}
