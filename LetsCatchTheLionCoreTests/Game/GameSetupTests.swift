// Created 23/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GameSetupTests: XCTestCase {

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
        XCTAssertEqual(3, tested.boardWidth)
    }

    func test_defaultGameCrearted_boardShouldBe4TilesHigh() {
        XCTAssertEqual(4, tested.boardHeight)
    }

    func test_forNewGame_groundPlayerShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .ground).isEmpty)
    }

    func test_forNewGame_skyPlayerShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .sky).isEmpty)
    }

    func test_forNewGame_currentPlayerShouldBeGroundPlayer() {
        let currentPlayer = tested.currentPlayer
        XCTAssertTrue(currentPlayer == .ground)
    }

    func test_newDobutsuGame_groundPlayerShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .ground).count)
    }

    func test_newDobutsuGame_skyPlayerShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .sky).count)
    }

    func test_newGoroGoroGame_groundPlayerShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .ground).count)
    }

    func test_newGoroGoroGame_skyPlayerShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .sky).count)
    }

    func test_beforeAnyMoves_gameIsOngoing() {
        guard case GameState.ongoing(_) = tested.state else {
            XCTFail()
            return
        }
    }
}
