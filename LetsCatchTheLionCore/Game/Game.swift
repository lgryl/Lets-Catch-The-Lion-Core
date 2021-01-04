// Created 31/12/2020

import Foundation

struct Game {
    let board: Board
    let player1 = Player()
    let player2 = Player()

    private(set) var currentPlayer: Player

    init(piecesArrangement: PiecesArrangement = DobutsuPiecesArrangement()) {
        do {
            let boardCreator = BoardCreator(player1: player1, player2: player2)
            board = try boardCreator.createBoard(from: piecesArrangement)
        } catch {
            board = Board()
        }
        currentPlayer = player1
    }
}
