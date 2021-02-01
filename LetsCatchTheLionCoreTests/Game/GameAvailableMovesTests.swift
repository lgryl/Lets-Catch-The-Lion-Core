// Created 26/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GameAvailableMovesTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_dobutsuGroundChick_onlyAvailableMoveIsUp() {
        guard let groundChick = tested.pieceAt(Position(x: 1, y: 2)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([Position(x: 1, y: 1)], tested.availableMoves(for: groundChick))
    }

    func test_dobutsuSkyChick_onlyAvailableMoveIsDown() {
        guard let skyChick = tested.pieceAt(Position(x: 1, y: 1)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([Position(x: 1, y: 2)], tested.availableMoves(for: skyChick))
    }

    func test_dobutsuGroundLion_availableMovesUpLeftAndUpRight() {
        guard let groundLion = tested.pieceAt(Position(x: 1, y: 3)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([Position(x: 0, y: 2), Position(x: 2, y: 2)], tested.availableMoves(for: groundLion))
    }

    func test_dobutsuSkyLion_availableMovesDownLeftAndDownRight() {
        guard let skyLion = tested.pieceAt(Position(x: 1, y: 0)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([Position(x: 0, y: 1), Position(x: 2, y: 1)], tested.availableMoves(for: skyLion))
    }

    func test_dobutsuGroundElephant_noAvailableMoves() {
        guard let groundElephant = tested.pieceAt(Position(x: 0, y: 3)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([], tested.availableMoves(for: groundElephant))
    }

    func test_dobutsuSkyElephant_noAvailableMoves() {
        guard let skyElephant = tested.pieceAt(Position(x: 2, y: 0)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([], tested.availableMoves(for: skyElephant))
    }

    func test_dobutsuSkyGiraffe_availableMovesUp() {
        guard let SkyGiraffe = tested.pieceAt(Position(x: 0, y: 0)) else {
            XCTFail()
            return
        }
        XCTAssertEqual([Position(x: 0, y: 1)], tested.availableMoves(for: SkyGiraffe))
    }
}
