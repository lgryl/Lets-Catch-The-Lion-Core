// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class GameTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(piecesArrangement: DobutsuPiecesArrangement())
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
        let player1 = tested.player1
        XCTAssertTrue(player1.capturedPieces.isEmpty)
    }

    func test_forNewGame_player2ShouldNotHaveAnyCapturedPieces() {
        let player2 = tested.player2
        XCTAssertTrue(player2.capturedPieces.isEmpty)
    }

    func test_forNewGame_currentPlayerShouldBePlayer1() {
        let currentPlayer = tested.currentPlayer
        XCTAssertTrue(currentPlayer == .player1)
    }

    func test_newDobutsuGame_player1ShouldHave4Pieces() {
        tested = Game(piecesArrangement: DobutsuPiecesArrangement())
        XCTAssertEqual(4, tested.player1.pieces.count)
    }

    func test_newDobutsuGame_player2ShouldHave4Pieces() {
        tested = Game(piecesArrangement: DobutsuPiecesArrangement())
        XCTAssertEqual(4, tested.player2.pieces.count)
    }

    func test_newGoroGoroGame_player1ShouldHave8Pieces() {
        tested = Game(piecesArrangement: GoroGoroPiecesArrangement())
        XCTAssertEqual(8, tested.player1.pieces.count)
    }

    func test_newGoroGoroGame_player2ShouldHave8Pieces() {
        tested = Game(piecesArrangement: GoroGoroPiecesArrangement())
        XCTAssertEqual(8, tested.player2.pieces.count)
    }

    func test_afterInvalidMove_currentPlayerIsStillPlayer1() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Point(x: 1, y: 2)),
              piece is Chick else {
            XCTFail()
            return
        }
        _ = try? tested.move(from: Point(x: 1, y: 2), to: Point(x: 1, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player1)
    }

    func test_afterValidMove_currentPlayerIsPlayer2() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Point(x: 2, y: 3)),
              piece is Giraffe else {
            XCTFail()
            return
        }
        _ = try? tested.move(from: Point(x: 2, y: 3), to: Point(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .player2)
    }

    func test_movingPieceOfNonCurrentPlayer_throwsException() {
        XCTAssertTrue(tested.currentPlayer == .player1)
        guard let piece = tested.board.pieceAt(Point(x: 0, y: 0)),
              piece is Giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.player2, piece.owner)
        XCTAssertThrowsError(try tested.move(from: Point(x: 0, y: 0), to: Point(x: 0, y: 1)))
    }
}
