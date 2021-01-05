// Created 31/12/2020

import Foundation

public class Game {
    let board: Board
    let player1 = Player()
    let player2 = Player()

    private(set) var currentPlayer: PlayerType = .player1

    init(piecesArrangement: PiecesArrangement = DobutsuPiecesArrangement()) {
        do {
            let boardCreator = BoardCreator(player1: player1, player2: player2)
            board = try boardCreator.createBoard(from: piecesArrangement)
        } catch {
            board = Board()
        }
    }

    public func move(from startPoint: Point, to endPoint: Point) throws {
        guard let pieceToMove = board.pieceAt(startPoint) else {
            throw Error.pieceNotFound
        }
        guard pieceToMove.owner == currentPlayer else {
            throw Error.playOrderViolation
        }
        try board.movePiece(from: startPoint, to: endPoint)
        startNextPlayerTurn()
    }

    private func startNextPlayerTurn() {
        currentPlayer.advance()
    }

    enum Error: Swift.Error {
        case pieceNotFound
        case playOrderViolation
    }
}
