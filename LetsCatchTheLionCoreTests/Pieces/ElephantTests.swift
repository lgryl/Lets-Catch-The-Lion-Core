// Created 05/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class ElephantTests: XCTestCase {
    var testedGroundElephant: Piece!
    var testedSkyElephant: Piece!

    override func setUp() {
        super.setUp()
        testedGroundElephant = Piece(.elephant, owner: .ground)
        testedSkyElephant = Piece(.elephant, owner: .sky)
    }

    override func tearDown() {
        testedSkyElephant = nil
        testedGroundElephant = nil
        super.tearDown()
    }

    func test_elephant_cantStayAtTheSameSquare() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_elephant_canMoveUpLeft() {
        XCTAssertTrue(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
        XCTAssertTrue(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_elephant_cantMoveTwoSquaresUpLeft() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
    }

    func test_elephant_canMoveUpRight() {
        XCTAssertTrue(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
        XCTAssertTrue(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_elephant_cantMoveTwoSquaresUpRightTwoSquares() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
    }

    func test_elephant_canMoveDownLeft() {
        XCTAssertTrue(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
        XCTAssertTrue(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_elephant_cantMoveTwoSquaresDownLeft() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
    }

    func test_elephant_canMoveDownRight() {
        XCTAssertTrue(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
        XCTAssertTrue(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_elephant_cantMoveTwoSquaresDownRight() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
    }

    func test_elephant_cantMoveUp() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_elephant_cantMoveDown() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_elephant_cantMoveLeft() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_elephant_cantMoveRight() {
        XCTAssertFalse(testedGroundElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertFalse(testedSkyElephant.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }
}
