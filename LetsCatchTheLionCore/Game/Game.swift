// Created 31/12/2020

import Foundation

public class Game {
    private let groundPlayer: Player
    private let skyPlayer: Player
    private let board: Board

    public var boardWidth: Int {
        board.width
    }

    public var boardHeight: Int {
        board.height
    }

    private(set) public var numberOfMoves = 0
    private(set) public var state: GameState = .ongoing(currentPlayer: .ground)

    public var currentPlayer: PlayerType? {
        guard case let GameState.ongoing(currentPlayer) = state else { return nil }
        return currentPlayer
    }

    public init(gameVariant: GameVariant) {
        groundPlayer = Player()
        skyPlayer = Player()

        let configuration = BoardConfigurationFactory.configuration(for: gameVariant)

        let boardCreator = BoardCreator(groundPlayer: groundPlayer, skyPlayer: skyPlayer)
        board = boardCreator.createBoard(from: configuration)
    }

    internal init(board: Board,
                  groundPlayer: Player = Player(),
                  skyPlayer: Player = Player()) {
        self.groundPlayer = groundPlayer
        self.skyPlayer = skyPlayer

        self.board = board
        for piece in board.allPieces {
            player(of: piece.owner).pieces.append(piece)
        }
    }
}

public extension Game {
    @discardableResult
    func canMove(from startPosition: Position, to endPosition: Position) -> Bool {
        guard let pieceToMove = board.pieceAt(startPosition) else {
            return false
        }
        guard board.pieceAt(endPosition) == nil || board.pieceAt(endPosition)?.owner != pieceToMove.owner else {
            return false
        }
        guard pieceToMove.allowsMove(from: startPosition, to: endPosition) else {
            return false
        }
        return true
    }

    func availableMoves(for piece: Piece) -> Set<Position> {
        guard let startPosition = board.position(of: piece) else {
            return []
        }
        var availableMoves: Set<Position> = []
        for x in 0 ..< board.width {
            for y in 0 ..< board.height {
                let endPosition = Position(x: x, y: y)
                if canMove(from: startPosition, to: endPosition) {
                    availableMoves.insert(endPosition)
                }
            }
        }
        return availableMoves
    }

    func move(from startPosition: Position, to endPosition: Position) throws {
        guard let piece = board.pieceAt(startPosition) else {
            throw GameError.pieceNotFound
        }
        try move(piece, to: endPosition)
    }

    func move(_ pieceToMove: Piece, to endPosition: Position) throws {
        guard case let GameState.ongoing(currentPlayer) = state else {
            throw GameError.gameAlreadyFinished
        }
        guard let startPosition = board.position(of: pieceToMove) else {
            throw GameError.pieceNotFound
        }
        guard player(of: pieceToMove.owner).pieces.contains(where: { $0 === pieceToMove }) else {
            throw GameError.pieceNotFound
        }
        guard pieceToMove.owner == currentPlayer else {
            throw GameError.playOrderViolation
        }
        guard board.pieceAt(endPosition) == nil || board.pieceAt(endPosition)?.owner != currentPlayer else {
            throw GameError.capturingOwnPiece
        }
        guard pieceToMove.allowsMove(from: startPosition, to: endPosition) else {
            throw GameError.illegalMove
        }
        let capturedPiece = try board.movePiece(from: startPosition, to: endPosition)
        numberOfMoves += 1
        capturedPiece?.powerDown()

        let capturedPieceSnapshot = capturedPiece?.copy() as? Piece
        if let capturedPiece = capturedPiece {
            capturedPiece.owner = capturedPiece.owner.next
            player(of: currentPlayer).capturedPieces.append(capturedPiece)
            player(of: currentPlayer.next).pieces.removeAll { $0 === capturedPiece }
        }

        if board.position(endPosition, withinPlayerArea: pieceToMove.owner.next) {
            pieceToMove.powerUp()
        }
        if let winner = checkForWinner(lastMovedPiece: pieceToMove,
                                       lastCapturedPiece: capturedPieceSnapshot) {
            state = .finished(winner: winner)
            return
        }
        startNextPlayerTurn()
    }

    func placeCapturedPiece(_ piece: Piece, at position: Position) throws {
        guard case let GameState.ongoing(currentPlayer) = state else {
            throw GameError.gameAlreadyFinished
        }
        guard player(of: currentPlayer).capturedPieces.contains(where: { $0 === piece }) else {
            throw GameError.pieceNotFound
        }
        guard piece.owner == currentPlayer else {
            throw GameError.playOrderViolation
        }
        guard board.pieceAt(position) == nil else {
            throw GameError.illegalMove
        }
        board.place(piece, at: position)
        numberOfMoves += 1
        startNextPlayerTurn()
    }

    func pieceAt(_ position: Position) -> Piece? {
        board.pieceAt(position)
    }

    func pieces(of playerType: PlayerType) -> [Piece] {
        player(of: playerType).pieces
    }

    func capturedPieces(of playerType: PlayerType) -> [Piece] {
        player(of: playerType).capturedPieces
    }
}

private extension Game {
    private func checkForWinner(lastMovedPiece: Piece, lastCapturedPiece: Piece?) -> PlayerType? {
        if lastCapturedPiece?.type == .lion {
            return lastCapturedPiece?.owner.next
        }
        guard let movedPiecePosition = board.position(of: lastMovedPiece) else {
            fatalError("Moved piece should be on the board")
        }
        let movedToOpponentsArea = board.position(movedPiecePosition, withinPlayerArea: lastMovedPiece.owner.next)
        let lastMovedPieceWasLion = lastMovedPiece.type == .lion
        let isSave = !canPieceBeCapturedInNextTurn(lastMovedPiece)
        if movedToOpponentsArea && lastMovedPieceWasLion && isSave {
            return lastMovedPiece.owner
        }

        return nil
    }

    private func canPieceBeCapturedInNextTurn(_ piece: Piece) -> Bool {
        guard let piecePosition = board.position(of: piece) else {
            fatalError("Piece should be on the board")
        }
        for opponentPiece in player(of: piece.owner.next).pieces {
            guard let opponentPiecePosition = board.position(of: opponentPiece) else {
                fatalError("Piece should be on the board")
            }
            if canMove(from: opponentPiecePosition, to: piecePosition) {
                return true
            }
        }
        return false
    }

    private func startNextPlayerTurn() {
        guard case let .ongoing(currentPlayer) = state else {
            preconditionFailure("Invalid game state")
        }
        state = .ongoing(currentPlayer: currentPlayer.next)
    }

    private func player(of type: PlayerType) -> Player {
        switch type {
        case .ground:
            return groundPlayer
        case .sky:
            return skyPlayer
        }
    }
}
