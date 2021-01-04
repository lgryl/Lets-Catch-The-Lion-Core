// Created 02/01/2021

import Foundation

protocol ArrayBasedPiecesArrangement: PiecesArrangement {
    var squareContents: [[SquareContent]] { get }
}

extension ArrayBasedPiecesArrangement {
    var width: Int {
        squareContents.count
    }
    var height: Int {
        squareContents[0].count
    }

    func squareContentAt(x: Int, y: Int) -> SquareContent {
        squareContents[x][y]
    }
}
