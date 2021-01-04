// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class GameTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game()
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
        let player1 = tested.player1
        let currentPlayer = tested.currentPlayer
        XCTAssertTrue(currentPlayer === player1)
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
}