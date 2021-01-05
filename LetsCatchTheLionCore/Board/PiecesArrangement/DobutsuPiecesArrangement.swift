// Created 02/01/2021

import Foundation

struct DobutsuPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 4),
              count: 3)

        squareContents[0][0] = Giraffe(owner: .player2)
        squareContents[1][0] = Lion(owner: .player2)
        squareContents[2][0] = Elephant(owner: .player2)
        squareContents[1][1] = Chick(owner: .player2)

        squareContents[1][2] = Chick(owner: .player1)
        squareContents[0][3] = Elephant(owner: .player1)
        squareContents[1][3] = Lion(owner: .player1)
        squareContents[2][3] = Giraffe(owner: .player1)

        return squareContents
    }()
}
