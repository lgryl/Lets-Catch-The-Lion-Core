// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class BoardTests: XCTestCase {
    private var tested: Board!

    override func setUp() {
        super.setUp()
        tested = Board(width: 3, height: 4, playerAreaHeight: 1)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_arbitraryBoard_hasPassedSize() throws {
        tested = Board(width: 7, height: 5, playerAreaHeight: 1)
        assertBoard(tested, hasWidth: 7, andHeight: 5)
    }

    func test_newBoard_hasNoPieces() {
        for x in 0 ..< tested.width {
            for y in 0 ..< tested.height {
                XCTAssertNil(tested.pieceAt(Position(x: x, y: y)))
            }
        }
    }

    func test_placingPieceOnBoard_hasEffect() {
        let lion = Piece(.lion, owner: .ground)
        tested.place(lion, at: Position(x: 1, y: 1))
        XCTAssertTrue(tested.pieceAt(Position(x: 1, y: 1)) === lion)
    }

    func test_placingPieceOutsideTheBoard_hasNoEffect() {
        tested = Board(width: 5, height: 5, playerAreaHeight: 1)
        tested.place(Piece(.lion, owner: .ground), at: Position(x: 6, y: 6))
        XCTAssertNil(tested.pieceAt(Position(x: 6, y: 6)))
    }

    func test_placingPieceOnOccupiedSquare_owerwritesPreviousPiece() {
        tested.place(Piece(.cat, owner: .ground), at: Position(x: 1, y: 1))
        let lion = Piece(.lion, owner: .ground)
        tested.place(lion, at: Position(x: 1, y: 1))
        XCTAssertTrue(tested.pieceAt(Position(x: 1, y: 1)) === lion)
    }

    func test_movingPiece_changesItsPositionOnBoard() throws {
        let lion = Piece(.lion, owner: .ground)
        tested.place(lion, at: Position(x: 0, y: 0))
        try tested.movePiece(from: Position(x: 0, y: 0), to: Position(x: 1, y: 1))
        XCTAssertNil(tested.pieceAt(Position(x: 0, y: 0)))
        XCTAssertTrue(tested.pieceAt(Position(x: 1, y: 1)) === lion)
    }

    func test_movingPieceToOccupiedPosition_changesItsPositionOnBoard() throws {
        let lion = Piece(.lion, owner: .ground)
        tested.place(lion, at: Position(x: 0, y: 0))
        tested.place(Piece(.cat, owner: .ground), at: Position(x: 1, y: 1))
        try tested.movePiece(from: Position(x: 0, y: 0), to: Position(x: 1, y: 1))
        XCTAssertNil(tested.pieceAt(Position(x: 0, y: 0)))
        XCTAssertTrue(tested.pieceAt(Position(x: 1, y: 1)) === lion)
    }

    func test_movingPieceToOccupiedPosition_returnsPreviousPiece() throws {
        tested.place(Piece(.lion, owner: .ground), at: Position(x: 0, y: 0))
        let cat = Piece(.cat, owner: .ground)
        tested.place(cat, at: Position(x: 1, y: 1))
        let previousPiece = try tested.movePiece(from: Position(x: 0, y: 0), to: Position(x: 1, y: 1))
        XCTAssertTrue(previousPiece === cat)
    }

    func test_movingEmptySquare_throwsException() {
        XCTAssertThrowsError(try tested.movePiece(from: Position(x: 1, y: 1), to: Position(x: 0, y: 0)))
    }

    func test_movingPieceFromOutsideTheBoard_throwsException() {
        XCTAssertThrowsError(try tested.movePiece(from: Position(x: 10, y: 10), to: Position(x: 0, y: 0)))
    }

    func test_movingPieceOutsideTheBoard_throwsException() {
        tested.place(Piece(.lion, owner: .ground), at: Position(x: 0, y: 0))
        XCTAssertThrowsError(try tested.movePiece(from: Position(x: 0, y: 0), to: Position(x: 10, y: 10)))
    }

    func test_movingPieceToTheSamePosition_throwsException() {
        tested.place(Piece(.lion, owner: .ground), at: Position(x: 1, y: 1))
        XCTAssertThrowsError(try tested.movePiece(from: Position(x: 1, y: 1), to: Position(x: 1, y: 1)))
    }
}
