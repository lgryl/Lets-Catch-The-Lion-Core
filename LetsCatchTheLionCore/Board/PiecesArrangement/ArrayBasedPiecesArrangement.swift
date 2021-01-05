// Created 02/01/2021

import Foundation

protocol ArrayBasedPiecesArrangement: PiecesArrangement {
    var squareContents: [[Piece?]] { get }
}

extension ArrayBasedPiecesArrangement {
    var width: Int {
        squareContents.count
    }
    var height: Int {
        squareContents[0].count
    }

    func pieceAt(x: Int, y: Int) -> Piece? {
        squareContents[x][y]
    }
}
