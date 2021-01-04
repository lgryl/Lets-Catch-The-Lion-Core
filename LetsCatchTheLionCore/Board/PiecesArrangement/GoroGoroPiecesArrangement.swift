// Created 02/01/2021

import Foundation

struct GoroGoroPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[SquareContent]] = {
        var squareContents: [[SquareContent]] = Array(repeating: Array(repeating: .none, count: 6),
              count: 5)

        squareContents[0][0] = .player1(Cat())
        squareContents[1][0] = .player1(Dog())
        squareContents[2][0] = .player1(Lion())
        squareContents[3][0] = .player1(Dog())
        squareContents[4][0] = .player1(Cat())
        squareContents[1][2] = .player1(Chick())
        squareContents[2][2] = .player1(Chick())
        squareContents[3][2] = .player1(Chick())

        squareContents[1][3] = .player2(Chick())
        squareContents[2][3] = .player2(Chick())
        squareContents[3][3] = .player2(Chick())
        squareContents[0][5] = .player2(Cat())
        squareContents[1][5] = .player2(Dog())
        squareContents[2][5] = .player2(Lion())
        squareContents[3][5] = .player2(Dog())
        squareContents[4][5] = .player2(Cat())

        return squareContents
    }()
}
