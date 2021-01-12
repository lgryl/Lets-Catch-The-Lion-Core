// Created 06/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GiraffeTests: XCTestCase {
    var tested: Giraffe!

    override func setUp() {
        super.setUp()
        tested = Giraffe(owner: .player1)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_giraffe_cantStayInTheSameSquare() {
        XCTAssertFalse(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 4)))
    }

    func test_giraffe_canMoveUp() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 3)))
    }

    func test_giraffe_canMoveUpTwoSquares() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 2)))
    }

    func test_giraffe_canMoveDown() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 5)))
    }

    func test_giraffe_canMoveDownTwoSquares() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 4, y: 6)))
    }

    func test_giraffe_canMoveLeft() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 3, y: 4)))
    }

    func test_giraffe_canMoveLeftTwoSquares() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 2, y: 4)))
    }

    func test_giraffe_canMoveRight() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 5, y: 4)))
    }

    func test_giraffe_canMoveRightTwoSquares() {
        XCTAssertTrue(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 6, y: 4)))
    }

    func test_giraffe_cantMoveUpLeft() {
        XCTAssertFalse(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 3, y: 3)))
    }

    func test_giraffe_cantMoveUpRigth() {
        XCTAssertFalse(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 5, y: 3)))
    }

    func test_giraffe_cantMoveDownLeft() {
        XCTAssertFalse(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 3, y: 5)))
    }

    func test_giraffe_cantMoveDownRigth() {
        XCTAssertFalse(tested.allowsMove(from: Point(x: 4, y: 4), to: Point(x: 5, y: 5)))
    }

}
