// Created 04/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class ChickTests: XCTestCase {
    var testedGroundChick: Piece!
    var testedSkyChick: Piece!

    override func setUp()  {
        super.setUp()
        testedGroundChick = Piece(.chick, owner: .ground)
        testedSkyChick = Piece(.chick, owner: .sky)
    }

    override func tearDown() {
        testedSkyChick = nil
        testedGroundChick = nil
        super.tearDown()
    }

    func test_chick_cantStayInTheSameSquare() {
        XCTAssertFalse(testedGroundChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(testedSkyChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
    }

    func test_groundPlayerChick_canMoveUp() {
        XCTAssertTrue(testedGroundChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_groundPlayerChich_cantMove2SquaresUp() {
        XCTAssertFalse(testedGroundChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 2)))
    }

    func test_groundPlayerChick_cantMoveDown() {
        XCTAssertFalse(testedGroundChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_skyPlayerChick_canMoveDown() {
        XCTAssertTrue(testedSkyChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_skyPlayerChick_cantMoveTwoSquaresDown() {
        XCTAssertFalse(testedSkyChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 6)))
    }

    func test_skyPlayerChick_cantMoveUp() {
        XCTAssertFalse(testedSkyChick.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_chich_canMoveToPositionWithNegativeCoordinates() {
        XCTAssertTrue(testedGroundChick.allowsMove(from: Position(x: 0, y: 0), to: Position(x: 0, y: -1)))
    }
}
