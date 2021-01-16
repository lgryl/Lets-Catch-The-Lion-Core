// Created 05/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class ElephantTests: XCTestCase {
    var tested1: Elephant!
    var tested2: Elephant!

    override func setUp() {
        super.setUp()
        tested1 = Elephant(owner: .player1)
        tested2 = Elephant(owner: .player2)
    }

    override func tearDown() {
        tested2 = nil
        tested1 = nil
        super.tearDown()
    }

    func test_elephant_cantStayAtTheSameSquare() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_elephant_canMoveUpLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_elephant_canMoveTwoSquaresUpLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
    }

    func test_elephant_canMoveUpRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_elephant_canMoveTwoSquaresUpRightTwoSquares() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
    }

    func test_elephant_canMoveDownLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_elephant_canMoveTwoSquaresDownLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
    }

    func test_elephant_canMoveDownRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_elephant_canMoveTwoSquaresDownRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
    }

    func test_elephant_cantMoveUp() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_elephant_cantMoveDown() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_elephant_cantMoveLeft() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_elephant_cantMoveRight() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }
}
