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

        XCTAssertEqual(board.pieceAt(Position(x: 0, y: 0))?.type, .cat)
        XCTAssertEqual(board.pieceAt(Position(x: 1, y: 0))?.type, .dog)
        XCTAssertEqual(board.pieceAt(Position(x: 2, y: 0))?.type, .lion)
        XCTAssertEqual(board.pieceAt(Position(x: 3, y: 0))?.type, .dog)
        XCTAssertEqual(board.pieceAt(Position(x: 4, y: 0))?.type, .cat)
        XCTAssertNil(board.pieceAt(Position(x: 0, y: 1)))
        XCTAssertNil(board.pieceAt(Position(x: 1, y: 1)))
        XCTAssertNil(board.pieceAt(Position(x: 2, y: 1)))
        XCTAssertNil(board.pieceAt(Position(x: 3, y: 1)))
        XCTAssertNil(board.pieceAt(Position(x: 4, y: 1)))
        XCTAssertNil(board.pieceAt(Position(x: 0, y: 2)))
        XCTAssertEqual(board.pieceAt(Position(x: 1, y: 2))?.type, .chick)
        XCTAssertEqual(board.pieceAt(Position(x: 2, y: 2))?.type, .chick)
        XCTAssertEqual(board.pieceAt(Position(x: 3, y: 2))?.type, .chick)
        XCTAssertNil(board.pieceAt(Position(x: 4, y: 2)))

        XCTAssertNil(board.pieceAt(Position(x: 0, y: 3)))
        XCTAssertEqual(board.pieceAt(Position(x: 1, y: 3))?.type, .chick)
        XCTAssertEqual(board.pieceAt(Position(x: 2, y: 3))?.type, .chick)
        XCTAssertEqual(board.pieceAt(Position(x: 3, y: 3))?.type, .chick)
        XCTAssertNil(board.pieceAt(Position(x: 4, y: 3)))
        XCTAssertNil(board.pieceAt(Position(x: 0, y: 4)))
        XCTAssertNil(board.pieceAt(Position(x: 1, y: 4)))
        XCTAssertNil(board.pieceAt(Position(x: 2, y: 4)))
        XCTAssertNil(board.pieceAt(Position(x: 3, y: 4)))
        XCTAssertNil(board.pieceAt(Position(x: 4, y: 4)))
        XCTAssertEqual(board.pieceAt(Position(x: 0, y: 5))?.type, .cat)
        XCTAssertEqual(board.pieceAt(Position(x: 1, y: 5))?.type, .dog)
        XCTAssertEqual(board.pieceAt(Position(x: 2, y: 5))?.type, .lion)
        XCTAssertEqual(board.pieceAt(Position(x: 3, y: 5))?.type, .dog)
        XCTAssertEqual(board.pieceAt(Position(x: 4, y: 5))?.type, .cat)
    }
}
