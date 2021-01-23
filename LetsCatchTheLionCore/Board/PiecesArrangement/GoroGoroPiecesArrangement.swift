// Created 02/01/2021

import Foundation

struct GoroGoroPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 6),
              count: 5)

        squareContents[0][0] = Piece(.cat, owner: .ground)
        squareContents[1][0] = Piece(.dog, owner: .ground)
        squareContents[2][0] = Piece(.lion, owner: .ground)
        squareContents[3][0] = Piece(.dog, owner: .ground)
        squareContents[4][0] = Piece(.cat, owner: .ground)
        squareContents[1][2] = Piece(.chick, owner: .ground)
        squareContents[2][2] = Piece(.chick, owner: .ground)
        squareContents[3][2] = Piece(.chick, owner: .ground)

        squareContents[1][3] = Piece(.chick, owner: .sky)
        squareContents[2][3] = Piece(.chick, owner: .sky)
        squareContents[3][3] = Piece(.chick, owner: .sky)
        squareContents[0][5] = Piece(.cat, owner: .sky)
        squareContents[1][5] = Piece(.dog, owner: .sky)
        squareContents[2][5] = Piece(.lion, owner: .sky)
        squareContents[3][5] = Piece(.dog, owner: .sky)
        squareContents[4][5] = Piece(.cat, owner: .sky)

        return squareContents
    }()
}
