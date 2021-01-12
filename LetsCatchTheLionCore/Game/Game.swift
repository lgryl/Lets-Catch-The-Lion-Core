// Created 31/12/2020

import Foundation

public class Game {
    let board: Board
    let player1 = Player()
    let player2 = Player()
    private(set) public var numberOfMoves = 0

    private(set) public var state: GameState = .ongoing(currentPlayer: .player1)

    public var currentPlayer: PlayerType? {
        guard case let GameState.ongoing(currentPlayer) = state else { return nil }
        return currentPlayer
    }

    public init(gameVariant: GameVariant) {
        let configuration = BoardConfigurationFactory.configuration(for: gameVariant)

        let boardCreator = BoardCreator(player1: player1, player2: player2)
        board = boardCreator.createBoard(from: configuration.piecesArrangement)
    }

    internal init(board: Board) {
        self.board = board
    }

    public func move(from startPoint: Point, to endPoint: Point) throws {
        guard case let GameState.ongoing(currentPlayer) = state else {
            throw Error.gameAlreadyFinished
        }
        guard let pieceToMove = board.pieceAt(startPoint) else {
            throw Error.pieceNotFound
        }
        guard pieceToMove.owner == currentPlayer else {
            throw Error.playOrderViolation
        }
        guard board.pieceAt(endPoint) == nil || board.pieceAt(endPoint)?.owner != currentPlayer else {
            throw Error.capturingOwnPiece
        }
        guard pieceToMove.allowsMove(from: startPoint, to: endPoint) else {
            throw Error.illegalMove
        }
        do {
            let capturedPiece = try board.movePiece(from: startPoint, to: endPoint)
            numberOfMoves += 1
            if let winner = checkForWinner(lastCapturedPiece: capturedPiece) {
                state = .finished(winner: winner)
                return
            }

            if let capturedPiece = capturedPiece {
                capturedPiece.owner = capturedPiece.owner.next
                player(of: currentPlayer).capturedPieces.append(capturedPiece)
                player(of: currentPlayer.next).pieces.removeAll { $0 === capturedPiece }
            }
            startNextPlayerTurn()
        } catch {
            throw error
        }
    }

    private func checkForWinner(lastCapturedPiece: Piece?) -> PlayerType? {
        if lastCapturedPiece is Lion {
            return lastCapturedPiece?.owner.next
        }
        return nil
    }

    private func startNextPlayerTurn() {
        guard case let .ongoing(currentPlayer) = state else {
            preconditionFailure("Invalid game state")
        }
        state = .ongoing(currentPlayer: currentPlayer.next)

    }

    private func player(of type: PlayerType) -> Player {
        switch type {
        case .player1:
            return player1
        case .player2:
            return player2
        }
    }

    enum Error: Swift.Error {
        case pieceNotFound
        case playOrderViolation
        case capturingOwnPiece
        case illegalMove
        case gameAlreadyFinished
    }
}
