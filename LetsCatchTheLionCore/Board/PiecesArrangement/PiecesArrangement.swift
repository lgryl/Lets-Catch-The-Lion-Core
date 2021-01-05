// Created 31/12/2020

import Foundation

public protocol PiecesArrangement {
    var width: Int { get }
    var height: Int { get }
    func pieceAt(x: Int, y: Int) -> Piece?
}
