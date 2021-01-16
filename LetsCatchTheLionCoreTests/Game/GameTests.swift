// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class GameTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_defaultGameCrearted_boardShouldBe3TilesWide() {
        let board = tested.board
        XCTAssertEqual(3, board.width)
    }

    func test_defaultGameCrearted_boardShouldBe4TilesHigh() {
        let board = tested.board
        XCTAssertEqual(4, board.height)
    }

    func test_forNewGame_player1ShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .player1).isEmpty)
    }

    func test_forNewGame_player2ShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .player2).isEmpty)
    }

    func test_forNewGame_currentPlayerShouldBePlayer1() {
        let currentPlayer = tested.currentPlayer
        XCTAssertTrue(currentPlayer == .player1)
    }

    func test_newDobutsuGame_player1ShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .player1).count)
    }

    func test_newDobutsuGame_player2ShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .player2).count)
    }

    func test_newGoroGoroGame_player1ShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .player1).count)
    }

    func test_newGoroGoroGame_player2ShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .player2).count)
    }

    func test_afterInvalidMove_currentPlayerIsStillPlayer1() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 1, y: 2)),
              piece is Chick else {
            XCTFail()
            return
        }
        _ = try? tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_afterValidMove_currentPlayerIsPlayer2() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece is Giraffe else {
            XCTFail()
            return
        }
        _ = try? tested.move(from: Position(x: 2, y: 3), to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player2)
    }

    func test_after2ValidMoves_currentPlayerIsPlayer1Again() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece1 = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece1 is Giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player1, piece1.owner)
        _ = try? tested.move(from: Position(x: 2, y: 3), to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player2)

        guard let piece2 = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece2 is Giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece2.owner)
        _ = try? tested.move(from: Position(x: 0, y: 0), to: Position(x: 0, y: 1))
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_movingPieceOfNonCurrentPlayer_throwsException() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece is Giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece.owner)
        XCTAssertThrowsError(try tested.move(from: Position(x: 0, y: 0), to: Position(x: 0, y: 1)))
    }

    func test_afterMovingPieceOfNonCurrentPlayer_turnDoesntChange() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece is Giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece.owner)
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_afterMovingPieceIntoOpponentsPiece_pieceIsCaptured() {
        guard let capturedPiece = tested.board.pieceAt(Position(x: 1, y: 1)) else {
            XCTFail()
            return
        }
        try? tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(1, tested.capturedPieces(of: .player1).count)
        XCTAssertTrue(capturedPiece === tested.capturedPieces(of: .player1)[0])
        XCTAssertEqual(3, tested.pieces(of: .player2).count)
    }

    func test_afterCapturingPiece_pieceChangesOwner() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Chick(owner: .player2), at: Position(x: 1, y: 1))
        board.place(Chick(owner: .player1), at: Position(x: 1, y: 2))
        tested = Game(board: board)

        guard let capturedPiece = tested.board.pieceAt(Position(x: 1, y: 1)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, capturedPiece.owner)
        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(.player1, capturedPiece.owner)
    }

    func test_movingPieceOnOwnPiece_throwsException() {
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 3), to: Position(x: 1, y: 2)))
    }

    func test_movingPieceOnOwnPiece_doesntChangeCurrentPlayer() {
        XCTAssertEqual(.player1, tested.currentPlayer)
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 3), to: Position(x: 1, y: 2)))
        XCTAssertEqual(.player1, tested.currentPlayer)
    }

    func test_beforeAnyMove_numberOfMovesIsZero() {
        XCTAssertEqual(0, tested.numberOfMoves)
    }

    func test_afterValidMove_numberOfMovesIncreases() throws {
        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(1, tested.numberOfMoves)
    }
    
    func test_afterInvalidMove_numberOfMovesDoesntIncrease() throws {
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 2)))
        XCTAssertEqual(0, tested.numberOfMoves)
    }

    func test_movingPieceViolatingItsMoveRules_throwsException() {
        XCTAssertThrowsError(try tested.move(from: Position(x: 0, y: 3), to: Position(x: 0, y: 2)))
    }

    func test_beforeAnyMoves_gameIsOngoing() {
        guard case GameState.ongoing(_) = tested.state else {
            XCTFail()
            return
        }
    }

    func test_whenPlayers2LionIsCaptured_player1Wins() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Lion(owner: .player2), at: Position(x: 1, y: 1))
        board.place(Lion(owner: .player1), at: Position(x: 1, y: 2))
        tested = Game(board: board)

        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.player1, winner)
        } else {
            XCTFail()
        }
    }

    func test_whenPlayers1LionIsCaptured_player2Wins() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Lion(owner: .player2), at: Position(x: 1, y: 1))
        board.place(Lion(owner: .player1), at: Position(x: 1, y: 2))
        tested = Game(board: board)

        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 2, y: 2))
        try tested.move(from: Position(x: 1, y: 1), to: Position(x: 2, y: 2))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.player2, winner)
        } else {
            XCTFail()
        }
    }

    func test_moveAfterVictory_throwsException() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Chick(owner: .player2), at: Position(x: 1, y: 0))
        board.place(Lion(owner: .player2), at: Position(x: 1, y: 1))
        board.place(Lion(owner: .player1), at: Position(x: 1, y: 2))
        tested = Game(board: board)

        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 0), to: Position(x: 1, y: 1)))
    }

    func test_afterReachingOpponentsArea_player1Wins() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Lion(owner: .player2), at: Position(x: 2, y: 2))
        board.place(Lion(owner: .player1), at: Position(x: 0, y: 1))
        tested = Game(board: board)
        do {
            try tested.move(from: Position(x: 0, y: 1), to: Position(x: 0, y: 0))
            guard case let .finished(winner) = tested.state else {
                XCTFail()
                return
            }
            guard winner == .player1 else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }

    func test_afterReachingOpponentsAreaWhenPlayer2CanCaptureLion_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        tested = Game(board: board)
        tested.place(Lion(owner: .player2), at: Position(x: 1, y: 0))
        tested.place(Lion(owner: .player1), at: Position(x: 0, y: 1))
        do {
            try tested.move(from: Position(x: 0, y: 1), to: Position(x: 0, y: 0))
            guard case let .ongoing(currentPlayer) = tested.state else {
                XCTFail()
                return
            }
            guard currentPlayer == .player2 else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }

    func test_afterReachingOpponentsAreaWhenPlayer1CanCaptureLion_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        tested = Game(board: board)
        tested.place(Lion(owner: .player2), at: Position(x: 2, y: 2))
        tested.place(Lion(owner: .player1), at: Position(x: 1, y: 2))
        do {
            try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 3))
            try tested.move(from: Position(x: 2, y: 2), to: Position(x: 2, y: 3))
            guard case let .ongoing(currentPlayer) = tested.state else {
                XCTFail()
                return
            }
            guard currentPlayer == .player1 else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }
}
