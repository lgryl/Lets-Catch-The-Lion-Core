// Created 03/01/2021

import Foundation

struct BoardCreator {
    let player1: Player
    let player2: Player

    func createBoard(from piecesArrangement: PiecesArrangement) throws -> Board {
        let board = try Board(width: piecesArrangement.width, height: piecesArrangement.height)
        for x in 0 ..< piecesArrangement.width {
            for y in 0 ..< piecesArrangement.height {
                switch piecesArrangement.squareContentAt(x: x, y: y) {
                case .none:
                    continue
                case .player1(let piece):
                    player1.pieces.append(piece)
                    board.place(piece, at: Point(x: x, y: y))
                case .player2(let piece):
                    player2.pieces.append(piece)
                    board.place(piece, at: Point(x: x, y: y))
                }
            }
        }
        return board
    }
}
