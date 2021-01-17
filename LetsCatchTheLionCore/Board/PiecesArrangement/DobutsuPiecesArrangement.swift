// Created 02/01/2021

import Foundation

struct DobutsuPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 4),
              count: 3)

        squareContents[0][0] = Piece(.giraffe, owner: .player2)
        squareContents[1][0] = Piece(.lion, owner: .player2)
        squareContents[2][0] = Piece(.elephant, owner: .player2)
        squareContents[1][1] = Piece(.chick, owner: .player2)

        squareContents[1][2] = Piece(.chick, owner: .player1)
        squareContents[0][3] = Piece(.elephant, owner: .player1)
        squareContents[1][3] = Piece(.lion, owner: .player1)
        squareContents[2][3] = Piece(.giraffe, owner: .player1)

        return squareContents
    }()
}
