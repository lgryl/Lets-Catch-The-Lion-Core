// Created 23/01/2021

import Foundation
@testable import LetsCatchTheLionCore

func createGame(boardWidth: Int = 3,
                         boardHeight: Int = 4,
                         playerAreaHeight: Int = 1,
                         with piecesAndPositions: (piece: Piece, position: Position)...) -> Game {
    let board = Board(width: boardWidth,
                      height: boardHeight,
                      playerAreaHeight: playerAreaHeight)
    for pair in piecesAndPositions {
        board.place(pair.piece, at: pair.position)
    }
    let game = Game(board: board)

    return game
}
