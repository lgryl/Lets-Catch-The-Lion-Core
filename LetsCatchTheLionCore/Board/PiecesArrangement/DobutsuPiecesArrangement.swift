// Created 02/01/2021

import Foundation

struct DobutsuPiecesArrangement: ArrayBasedPiecesArrangement {
    var squareContents: [[Piece?]] = {
        var squareContents: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 4),
              count: 3)

        squareContents[0][0] = Piece(.giraffe, owner: .sky)
        squareContents[1][0] = Piece(.lion, owner: .sky)
        squareContents[2][0] = Piece(.elephant, owner: .sky)
        squareContents[1][1] = Piece(.chick, owner: .sky)

        squareContents[1][2] = Piece(.chick, owner: .ground)
        squareContents[0][3] = Piece(.elephant, owner: .ground)
        squareContents[1][3] = Piece(.lion, owner: .ground)
        squareContents[2][3] = Piece(.giraffe, owner: .ground)

        return squareContents
    }()
}
