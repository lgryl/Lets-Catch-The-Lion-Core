// Created 04/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class LionTests: XCTestCase {
    var testedGroundLion: Piece!
    var testedSkyLion: Piece!

    override func setUp()  {
        super.setUp()
        testedGroundLion = Piece(.lion, owner: .ground)
        testedSkyLion = Piece(.lion, owner: .sky)
    }

    override func tearDown() {
        testedSkyLion = nil
        testedGroundLion = nil
        super.tearDown()
    }

    func test_lion_cantStayInTheSameSquare() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_lion_canMoveUp() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_lion_canMoveDown() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_lion_canMoveLeft() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_lion_canMoveRight() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_lion_canMoveUpLeft() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_lion_canMoveUpRight() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_lion_canMoveDownLeft() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_lion_canMoveDownRight() {
        XCTAssertTrue(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
        XCTAssertTrue(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_lion_cantMoveTwoSquaresUp() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresDown() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
    }

    func test_lion_cantMoveTwoSquaresLeft() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 4)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 4)))
    }

    func test_lion_cantMoveTwoSquaresRight() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 4)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 4)))
    }

    func test_lion_cantMoveTwoSquaresUpLeft() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresUpRight() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 2)))
    }

    func test_lion_cantMoveTwoSquaresDownLeft() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 2, y: 6)))
    }

    func test_lion_cantMoveTwoSquaresDownRight() {
        XCTAssertFalse(testedGroundLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
        XCTAssertFalse(testedSkyLion.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 6, y: 6)))
    }
}
