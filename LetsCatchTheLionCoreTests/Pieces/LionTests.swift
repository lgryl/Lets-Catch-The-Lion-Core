// Created 04/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class LionTests: XCTestCase {
    var tested1: Lion!
    var tested2: Lion!

    override func setUp()  {
        super.setUp()
        tested1 = Lion(owner: .player1)
        tested2 = Lion(owner: .player2)
    }

    override func tearDown() {
        tested2 = nil
        tested1 = nil
        super.tearDown()
    }

    func test_lion_cantStayInTheSameSquare() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_lion_canMoveUp() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_lion_canMoveDown() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_lion_canMoveLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_lion_canMoveRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_lion_canMoveUpLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_lion_canMoveUpRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_lion_canMoveDownLeft() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_lion_canMoveDownRight() {
        XCTAssertTrue(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
        XCTAssertTrue(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_lion_cantMoveTwoSquaresUp() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresDown() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
    }

    func test_lion_cantMoveTwoSquaresLeft() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 4)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 4)))
    }

    func test_lion_cantMoveTwoSquaresRight() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 4)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 4)))
    }

    func test_lion_cantMoveTwoSquaresUpLeft() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresUpRight() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresDownLeft() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
    }

    func test_lion_cantMoveTwoSquaresDownRight() {
        XCTAssertFalse(tested1.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
        XCTAssertFalse(tested2.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
    }
}
