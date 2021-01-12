// Created 03/01/2021

import Foundation

internal struct BoardCreator {
    let player1: Player
    let player2: Player

    func createBoard(from piecesArrangement: PiecesArrangement) -> Board {
        let board = Board(width: piecesArrangement.width, height: piecesArrangement.height)
        for x in 0 ..< piecesArrangement.width {
            for y in 0 ..< piecesArrangement.height {
                if let piece = piecesArrangement.pieceAt(x: x, y: y) {
                    switch piece.owner {
                    case .player1:
                        player1.pieces.append(piece)
                    case .player2:
                        player2.pieces.append(piece)
                    }
                    board.place(piece, at: Point(x: x, y: y))
                }
            }
        }
        return board
    }
}
