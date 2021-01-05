// Created 04/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class ChickTests: XCTestCase {
    var tested1: Chick!
    var tested2: Chick!

    override func setUp()  {
        super.setUp()
        tested1 = Chick(owner: .player1)
        tested2 = Chick(owner: .player2)
    }

    override func tearDown() {
        tested2 = nil
        tested1 = nil
        super.tearDown()
    }

    func test_player1Chick_canMoveUp() {
        XCTAssertTrue(tested1.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 3)))
    }

    func test_player1Chich_cantMove2SquaresUp() {
        XCTAssertFalse(tested1.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 2)))
    }

    func test_player1Chick_cantMoveDown() {
        XCTAssertFalse(tested1.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 5)))
    }

    func test_player2Chick_canMoveDown() {
        XCTAssertTrue(tested2.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 5)))
    }

    func test_player2Chick_cantMoveTwoSquaresDown() {
        XCTAssertFalse(tested2.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 6)))
    }

    func test_player2Chick_cantMoveUp() {
        XCTAssertFalse(tested2.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 3)))
    }

    func test_chich_canMoveToPositionWithNegativeCoordinates() {
        XCTAssertTrue(tested1.allowsMove(from: Point(x: 0, y: 0), to: Point(x: 0, y: -1)))
    }
}
