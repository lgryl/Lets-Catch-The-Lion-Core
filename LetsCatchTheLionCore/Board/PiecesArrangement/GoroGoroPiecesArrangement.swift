// Created 02/01/2021

import Foundation

struct GoroGoroPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 6),
              count: 5)

        squareContents[0][0] = Cat(owner: .player1)
        squareContents[1][0] = Dog(owner: .player1)
        squareContents[2][0] = Lion(owner: .player1)
        squareContents[3][0] = Dog(owner: .player1)
        squareContents[4][0] = Cat(owner: .player1)
        squareContents[1][2] = Chick(owner: .player1)
        squareContents[2][2] = Chick(owner: .player1)
        squareContents[3][2] = Chick(owner: .player1)

        squareContents[1][3] = Chick(owner: .player2)
        squareContents[2][3] = Chick(owner: .player2)
        squareContents[3][3] = Chick(owner: .player2)
        squareContents[0][5] = Cat(owner: .player2)
        squareContents[1][5] = Dog(owner: .player2)
        squareContents[2][5] = Lion(owner: .player2)
        squareContents[3][5] = Dog(owner: .player2)
        squareContents[4][5] = Cat(owner: .player2)

        return squareContents
    }()
}
