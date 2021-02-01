// Created 06/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GiraffeTests: XCTestCase {
    var tested: Piece!

    override func setUp() {
        super.setUp()
        tested = Piece(.giraffe, owner: .ground)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_giraffe_cantStayInTheSameSquare() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_giraffe_canMoveUp() {
        XCTAssertTrue(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_giraffe_cantMoveUpTwoSquares() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
    }

    func test_giraffe_canMoveDown() {
        XCTAssertTrue(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_giraffe_cantMoveDownTwoSquares() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
    }

    func test_giraffe_canMoveLeft() {
        XCTAssertTrue(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_giraffe_cantMoveLeftTwoSquares() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 4)))
    }

    func test_giraffe_canMoveRight() {
        XCTAssertTrue(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_giraffe_cantMoveRightTwoSquares() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 4)))
    }

    func test_giraffe_cantMoveUpLeft() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_giraffe_cantMoveUpRigth() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_giraffe_cantMoveDownLeft() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_giraffe_cantMoveDownRigth() {
        XCTAssertFalse(tested.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

}
