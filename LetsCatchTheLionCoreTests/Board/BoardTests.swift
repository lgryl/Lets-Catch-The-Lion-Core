// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class BoardTests: XCTestCase {
    private var tested: Board!

    override func setUp() {
        super.setUp()
        tested = Board()
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_defaultBoard_is3x4() {
        assertBoard(tested, hasWidth: 3, andHeight: 4)
    }

    func test_arbitraryBoard_hasPassedSize() throws {
        tested = try Board(width: 7, height: 5)
        assertBoard(tested, hasWidth: 7, andHeight: 5)
    }

    func test_arbitraryBoardOfWidthLessThan3_throwsException() {
        XCTAssertThrowsError(try Board(width: 2, height: 5))
    }

    func test_arbitraryBoardOfHeightLessThan4_throwsException() {
        XCTAssertThrowsError(try Board(width: 7, height: 3))
    }

    func test_arbitraryBoardOfWidthMoreThan9_throwsException() {
        XCTAssertThrowsError(try Board(width: 10, height: 9))
    }

    func test_arbitraryBoardOfHeightMoreThan9_throwsException() {
        XCTAssertThrowsError(try Board(width: 9, height: 10))
    }

    func test_newBoard_hasNoPieces() {
        for x in 0 ..< tested.width {
            for y in 0 ..< tested.height {
                XCTAssertNil(tested.pieceAt(Point(x: x, y: y)))
            }
        }
    }

    func test_placingPieceOnBoard_hasEffect() {
        tested.place(Lion(), at: Point(x: 1, y: 1))
        XCTAssertTrue(tested.pieceAt(Point(x: 1, y: 1)) is Lion)
    }

    func test_placingPieceOutsideTheBoard_hasNoEffect() throws {
        tested = try Board(width: 5, height: 5)
        tested.place(Lion(), at: Point(x: 6, y: 6))
        XCTAssertNil(tested.pieceAt(Point(x: 6, y: 6)))
    }

    func test_placingPieceOnOccupiedSquare_owerwritesPreviousPiece() {
        tested.place(Cat(), at: Point(x: 1, y: 1))
        tested.place(Lion(), at: Point(x: 1, y: 1))
        XCTAssertTrue(tested.pieceAt(Point(x: 1, y: 1)) is Lion)
    }

    func test_movingPiece_changesItsPositionOnBoard() throws {
        tested.place(Lion(), at: Point(x: 0, y: 0))
        try tested.movePiece(from: Point(x: 0, y: 0), to: Point(x: 1, y: 1))
        XCTAssertNil(tested.pieceAt(Point(x: 0, y: 0)))
        XCTAssertTrue(tested.pieceAt(Point(x: 1, y: 1)) is Lion)
    }

    func test_movingPieceToOccupiedPosition_changesItsPositionOnBoard() throws {
        tested.place(Lion(), at: Point(x: 0, y: 0))
        tested.place(Cat(), at: Point(x: 1, y: 1))
        try tested.movePiece(from: Point(x: 0, y: 0), to: Point(x: 1, y: 1))
        XCTAssertNil(tested.pieceAt(Point(x: 0, y: 0)))
        XCTAssertTrue(tested.pieceAt(Point(x: 1, y: 1)) is Lion)
    }

    func test_movingPieceToOccupiedPosition_returnsPreviousPiece() throws {
        tested.place(Lion(), at: Point(x: 0, y: 0))
        tested.place(Cat(), at: Point(x: 1, y: 1))
        let previousPiece = try tested.movePiece(from: Point(x: 0, y: 0), to: Point(x: 1, y: 1))
        XCTAssertTrue(previousPiece is Cat)
    }

    func test_movingEmptySquare_throwsException() {
        XCTAssertThrowsError(try tested.movePiece(from: Point(x: 1, y: 1), to: Point(x: 0, y: 0)))
    }

    func test_movingPieceFromOutsideTheBoard_throwsException() {
        XCTAssertThrowsError(try tested.movePiece(from: Point(x: 10, y: 10), to: Point(x: 0, y: 0)))
    }

    func test_movingPieceOutsideTheBoard_throwsException() {
        tested.place(Lion(), at: Point(x: 0, y: 0))
        XCTAssertThrowsError(try tested.movePiece(from: Point(x: 0, y: 0), to: Point(x: 10, y: 10)))
    }

    func test_movingPieceToTheSamePosition_throwsException() {
        tested.place(Lion(), at: Point(x: 1, y: 1))
        XCTAssertThrowsError(try tested.movePiece(from: Point(x: 1, y: 1), to: Point(x: 1, y: 1)))
    }
}
