// Created 02/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GoroGoroBoardCreatorTests: XCTestCase {
    private var tested: BoardCreator!
    private var player1: Player!
    private var player2: Player!

    override func setUpWithError() throws {
        super.setUp()
        player1 = Player()
        player2 = Player()
        tested = BoardCreator(player1: player1, player2: player2)
    }

    override func tearDown() {
        tested = nil
        player2 = nil
        player1 = nil
        super.tearDown()
    }

    func test_goroGoroBoard_is5x6() {
        let board = tested.createBoard(from: BoardConfigurationFactory.configuration(for: .goroGoro))
        assertBoard(board, hasWidth: 5, andHeight: 6)
    }

    func test_dobutsuBoard_hasCorrectSetup() {
        let board = tested.createBoard(from: BoardConfigurationFactory.configuration(for: .goroGoro))

        XCTAssertTrue(board.pieceAt(Point(x: 0, y: 0)) is Cat)
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 0)) is Dog)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 0)) is Lion)
        XCTAssertTrue(board.pieceAt(Point(x: 3, y: 0)) is Dog)
        XCTAssertTrue(board.pieceAt(Point(x: 4, y: 0)) is Cat)
        XCTAssertNil(board.pieceAt(Point(x: 0, y: 1)))
        XCTAssertNil(board.pieceAt(Point(x: 1, y: 1)))
        XCTAssertNil(board.pieceAt(Point(x: 2, y: 1)))
        XCTAssertNil(board.pieceAt(Point(x: 3, y: 1)))
        XCTAssertNil(board.pieceAt(Point(x: 4, y: 1)))
        XCTAssertNil(board.pieceAt(Point(x: 0, y: 2)))
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 2)) is Chick)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 2)) is Chick)
        XCTAssertTrue(board.pieceAt(Point(x: 3, y: 2)) is Chick)
        XCTAssertNil(board.pieceAt(Point(x: 4, y: 2)))

        XCTAssertNil(board.pieceAt(Point(x: 0, y: 3)))
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 3)) is Chick)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 3)) is Chick)
        XCTAssertTrue(board.pieceAt(Point(x: 3, y: 3)) is Chick)
        XCTAssertNil(board.pieceAt(Point(x: 4, y: 3)))
        XCTAssertNil(board.pieceAt(Point(x: 0, y: 4)))
        XCTAssertNil(board.pieceAt(Point(x: 1, y: 4)))
        XCTAssertNil(board.pieceAt(Point(x: 2, y: 4)))
        XCTAssertNil(board.pieceAt(Point(x: 3, y: 4)))
        XCTAssertNil(board.pieceAt(Point(x: 4, y: 4)))
        XCTAssertTrue(board.pieceAt(Point(x: 0, y: 5)) is Cat)
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 5)) is Dog)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 5)) is Lion)
        XCTAssertTrue(board.pieceAt(Point(x: 3, y: 5)) is Dog)
        XCTAssertTrue(board.pieceAt(Point(x: 4, y: 5)) is Cat)
    }
}
