// Created 03/01/2021

import Foundation

internal struct BoardCreator {
    let player1: Player
    let player2: Player

    func createBoard(from configuration: BoardConfiguration) -> Board {
        let board = Board(width: configuration.piecesArrangement.width,
                          height: configuration.piecesArrangement.height,
                          playerAreaHeight: configuration.playerAreaHeight)
        for x in 0 ..< configuration.piecesArrangement.width {
            for y in 0 ..< configuration.piecesArrangement.height {
                if let piece = configuration.piecesArrangement.pieceAt(x: x, y: y) {
                    switch piece.owner {
                    case .player1:
                        player1.pieces.append(piece)
                    case .player2:
                        player2.pieces.append(piece)
                    }
                    board.place(piece, at: Position(x: x, y: y))
                }
            }
        }
        return board
    }
}
