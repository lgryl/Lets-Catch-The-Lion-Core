// Created 02/01/2021

import Foundation

struct GoroGoroPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 6),
              count: 5)

        squareContents[0][0] = Piece(.cat, owner: .player1)
        squareContents[1][0] = Piece(.dog, owner: .player1)
        squareContents[2][0] = Piece(.lion, owner: .player1)
        squareContents[3][0] = Piece(.dog, owner: .player1)
        squareContents[4][0] = Piece(.cat, owner: .player1)
        squareContents[1][2] = Piece(.chick, owner: .player1)
        squareContents[2][2] = Piece(.chick, owner: .player1)
        squareContents[3][2] = Piece(.chick, owner: .player1)

        squareContents[1][3] = Piece(.chick, owner: .player2)
        squareContents[2][3] = Piece(.chick, owner: .player2)
        squareContents[3][3] = Piece(.chick, owner: .player2)
        squareContents[0][5] = Piece(.cat, owner: .player2)
        squareContents[1][5] = Piece(.dog, owner: .player2)
        squareContents[2][5] = Piece(.lion, owner: .player2)
        squareContents[3][5] = Piece(.dog, owner: .player2)
        squareContents[4][5] = Piece(.cat, owner: .player2)

        return squareContents
    }()
}
