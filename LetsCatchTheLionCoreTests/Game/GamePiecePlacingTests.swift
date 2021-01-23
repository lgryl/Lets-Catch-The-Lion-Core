// Created 23/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GamePiecePlacingTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_placingPieceThatIsNotCaptured_throwsError() {
        let newPiece = Piece(.chick, owner: .ground)
        XCTAssertThrowsError(try tested.placeCapturedPiece(newPiece, at: Position(x: 2, y: 3)))
    }
}
