// Created 17/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class HenTests: XCTestCase {
    var testedGroundHen: Piece!
    var testedSkyHen: Piece!

    override func setUp() {
        super.setUp()
        testedGroundHen = Piece(.hen, owner: .ground)
        testedSkyHen = Piece(.hen, owner: .sky)
    }

    override func tearDown() {
        testedSkyHen = nil
        testedGroundHen = nil
        super.tearDown()
    }

    func test_hen_cantStayInTheSameSquare() {
        XCTAssertFalse(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))
        XCTAssertFalse(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 4)))

    }

    func test_groundPlayerHen_canMoveUp() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_groundPlayerHen_canMoveUpLeft() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_groundPlayerHen_canMoveUpRight() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }

    func test_groundPlayerHen_canMoveLeft() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_groundPlayerHen_canMoveRight() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_groundPlayerHen_canMoveDown() {
        XCTAssertTrue(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_groundPlayerHen_cantMoveDownLeft() {
        XCTAssertFalse(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_groundPlayerHen_cantMoveDownRight() {
        XCTAssertFalse(testedGroundHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_skyPlayerHen_canMoveDown() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 5)))
    }

    func test_skyPlayerHen_canMoveDownLeft() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 5)))
    }

    func test_skyPlayerHen_canMoveDownRight() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 5)))
    }

    func test_skyPlayerHen_canMoveLeft() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 4)))
    }

    func test_skyPlayerHen_canMoveRight() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 4)))
    }

    func test_skyPlayerHen_canMoveUp() {
        XCTAssertTrue(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 4, y: 3)))
    }

    func test_skyPlayerHen_cantMoveUpLeft() {
        XCTAssertFalse(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 3, y: 3)))
    }

    func test_skyPlayerHen_cantMoveUpRigth() {
        XCTAssertFalse(testedSkyHen.allowsMove(from: Position(x: 4, y: 4), to: Position(x: 5, y: 3)))
    }
}
