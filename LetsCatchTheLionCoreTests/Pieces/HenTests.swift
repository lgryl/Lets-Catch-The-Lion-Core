// Created 17/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class HenTests: XCTestCase {
    var tested1: Piece!
    var tested2: Piece!

    override func setUp() {
        super.setUp()
        tested1 = Piece(.hen, owner: .player1)
        tested2 = Piece(.hen, owner: .player2)
    }

    override func tearDown() {
        tested2 = nil
        tested1 = nil
        super.tearDown()
    }

    func test_hen_cantStayInTheSameSquare() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))

    }

    func test_player1Hen_canMoveUp() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_player1Hen_canMoveUpLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_player1Hen_canMoveUpRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_player1Hen_canMoveLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_player1Hen_canMoveRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_player1Hen_canMoveDown() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_player1Hen_cantMoveDownLeft() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_player1Hen_cantMoveDownRight() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_player2Hen_canMoveDown() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_player2Hen_canMoveDownLeft() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_player2Hen_canMoveDownRight() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_player2Hen_canMoveLeft() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_player2Hen_canMoveRight() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_player2Hen_canMoveUp() {
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_player2Hen_cantMoveUpLeft() {
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_player2Hen_cantMoveUpRigth() {
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }
}
