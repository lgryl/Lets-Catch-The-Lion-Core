// Created 02/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class DobutsuBoardCreatorTests: XCTestCase {
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

    func test_dobutsuBoard_is3x4() {
        let board = tested.createBoard(from: BoardConfigurationFactory.configuration(for: .dobutsu))
        assertBoard(board, hasWidth: 3, andHeight: 4)
    }

    func test_dobutsuBoard_hasCorrectSetup() {
        let board = tested.createBoard(from: BoardConfigurationFactory.configuration(for: .dobutsu))

        XCTAssertTrue(board.pieceAt(Point(x: 0, y: 0)) is Giraffe)
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 0)) is Lion)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 0)) is Elephant)
        XCTAssertNil(board.pieceAt(Point(x: 0, y: 1)))
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 1)) is Chick)
        XCTAssertNil(board.pieceAt(Point(x: 2, y: 1)))

        XCTAssertNil(board.pieceAt(Point(x: 0, y: 2)))
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 2)) is Chick)
        XCTAssertNil(board.pieceAt(Point(x: 2, y: 2)))
        XCTAssertTrue(board.pieceAt(Point(x: 0, y: 3)) is Elephant)
        XCTAssertTrue(board.pieceAt(Point(x: 1, y: 3)) is Lion)
        XCTAssertTrue(board.pieceAt(Point(x: 2, y: 3)) is Giraffe)
    }
}
