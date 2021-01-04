// Created 02/01/2021

import Foundation

struct DobutsuPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[SquareContent]] = {
        var squareContents: [[SquareContent]] = Array(repeating: Array(repeating: .none, count: 4),
              count: 3)

        squareContents[0][0] = .player1(Giraffe())
        squareContents[1][0] = .player1(Lion())
        squareContents[2][0] = .player1(Elephant())
        squareContents[1][1] = .player1(Chick())

        squareContents[1][2] = .player2(Chick())
        squareContents[0][3] = .player2(Elephant())
        squareContents[1][3] = .player2(Lion())
        squareContents[2][3] = .player2(Giraffe())

        return squareContents
    }()
}
