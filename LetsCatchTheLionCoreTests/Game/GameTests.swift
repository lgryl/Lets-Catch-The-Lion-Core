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
              piece.type == .chick else {
            XCTFail()
            return
        }
        _ = try? tested.move(piece, to: Position(x: 1, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_afterValidMove_currentPlayerIsPlayer2() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece.type == .giraffe else {
            XCTFail()
            return
        }
        _ = try? tested.move(piece, to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player2)
    }

    func test_after2ValidMoves_currentPlayerIsPlayer1Again() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece1 = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece1.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player1, piece1.owner)
        _ = try? tested.move(piece1, to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player2)

        guard let piece2 = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece2.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece2.owner)
        _ = try? tested.move(piece2, to: Position(x: 0, y: 1))
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_movingPieceOfNonCurrentPlayer_throwsException() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece.owner)
        XCTAssertThrowsError(try tested.move(piece, to: Position(x: 0, y: 1)))
    }

    func test_movingPieceNotBelongingToCurrentPlayer_throwsException() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        tested = Game(board: board)
        let piece = Piece(.chick, owner: .player1)
        board.place(piece, at: Position(x: 2, y: 2))
        XCTAssertThrowsError(try tested.move(piece, to: Position(x: 2, y: 1)))
    }

    func test_afterMovingPieceOfNonCurrentPlayer_turnDoesntChange() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece.type == .giraffe else {
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
        board.place(Piece(.chick, owner: .player2), at: Position(x: 1, y: 1))
        board.place(Piece(.chick, owner: .player1), at: Position(x: 1, y: 2))
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
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 1, y: 2))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(lion1, to: Position(x: 1, y: 1))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.player1, winner)
        } else {
            XCTFail()
        }
    }

    func test_whenPlayers1LionIsCaptured_player2Wins() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 1, y: 2))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(lion1, to: Position(x: 2, y: 2))
        try tested.move(lion2, to: Position(x: 2, y: 2))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.player2, winner)
        } else {
            XCTFail()
        }
    }

    func test_moveAfterVictory_throwsException() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 1, y: 2))
        let chick2 = Piece(.chick, owner: .player2)
        board.place(chick2, at: Position(x: 1, y: 0))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(lion1, to: Position(x: 1, y: 1))
        XCTAssertThrowsError(try tested.move(chick2, to: Position(x: 1, y: 1)))
    }

    func test_whenPlayer1LionReachesOpponentsArea_player1Wins() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 0, y: 1))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 2, y: 2))
        tested = Game(board: board)
        do {
            try tested.move(lion1, to: Position(x: 0, y: 0))
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

    func test_afterPlayer1LionReachesOpponentsAreaAndCanBeCaptured_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 0, y: 1))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 1, y: 0))
        tested = Game(board: board)
        do {
            try tested.move(lion1, to: Position(x: 0, y: 0))
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

    func test_afterPlayer2LionReachesOpponentsAreaAndCanBeCaptured_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let lion1 = Piece(.lion, owner: .player1)
        board.place(lion1, at: Position(x: 1, y: 2))
        let lion2 = Piece(.lion, owner: .player2)
        board.place(lion2, at: Position(x: 2, y: 2))
        tested = Game(board: board)
        do {
            try tested.move(lion1, to: Position(x: 1, y: 3))
            try tested.move(lion2, to: Position(x: 2, y: 3))
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

    func test_whenPlayer1NonLionReachesOpponentArea_gameContinues() throws {
        let chick1 = Piece(.chick, owner: .player1)
        let chick2 = Piece(.chick, owner: .player2)
        tested = createGame(with: (piece: chick1, position: Position(x: 0, y: 1)),
                                (piece: chick2, position: Position(x: 2, y: 1)))
        try tested.move(chick1, to: Position(x: 0, y: 0))
        guard case let .ongoing(currentPlayer) = tested.state else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, currentPlayer)
    }

    func test_whenChickReachesOpponentsArea_itCanGoBack() throws {
        let chick1 = Piece(.chick, owner: .player1)
        let chick2 = Piece(.chick, owner: .player2)
        tested = createGame(with: (piece: chick1, position: Position(x: 0, y: 1)),
                                (piece: chick2, position: Position(x: 2, y: 1)))
        XCTAssertThrowsError(try tested.move(chick1, to: Position(x: 0, y: 2)))
        try tested.move(chick1, to: Position(x: 0, y: 0))
        try tested.move(chick2, to: Position(x: 2, y: 2))
        XCTAssertNoThrow(try tested.move(chick1, to: Position(x: 0, y: 1)))
    }

    func test_whenChickReachesOpponentsArea_itBecamesHen() throws {
        let chick1 = Piece(.chick, owner: .player1)
        let chick2 = Piece(.chick, owner: .player2)
        tested = createGame(with: (piece: chick1, position: Position(x: 0, y: 1)),
                                (piece: chick2, position: Position(x: 2, y: 1)))
        XCTAssertEqual(.chick, chick1.type)
        try tested.move(chick1, to: Position(x: 0, y: 0))
        XCTAssertEqual(.hen, chick1.type)
    }

    func test_whenHenIsCaptured_itBecamesChick() throws {
        let chick1 = Piece(.chick, owner: .player1)
        let hen2 = Piece(.hen, owner: .player2)
        tested = createGame(with: (piece: chick1, position: Position(x: 1, y: 2)),
                                (piece: hen2, position: Position(x: 1, y: 1)))

        XCTAssertEqual(.hen, hen2.type)
        try tested.move(chick1, to: Position(x: 1, y: 1))
        XCTAssertEqual(.chick, hen2.type)
    }

    func test_placingPieceThatIsNotCaptured_throwsError() {
        let newPiece = Piece(.chick, owner: .player1)
        XCTAssertThrowsError(try tested.placeCapturedPiece(newPiece, at: Position(x: 2, y: 3)))
    }

    private func createGame(boardWidth: Int = 3,
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
}
