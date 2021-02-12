// Created 23/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GamePiecePlacingTests: XCTestCase {
    private var tested: Game!
    private var board: Board!
    private var groundPlayerLion: Piece!
    private var skyPlayerLion: Piece!
    private var groundPlayerCapturedChick: Piece!
    private var skyPlayerCapturedChick: Piece!

    override func setUp() {
        super.setUp()
        board = Board(width: 3, height: 4, playerAreaHeight: 1)

        let groundPlayer = Player()
        groundPlayerLion = Piece(.lion, owner: .ground)
        groundPlayer.pieces.append(groundPlayerLion)
        groundPlayerCapturedChick = Piece(.chick, owner: .ground)
        groundPlayer.capturedPieces.append(groundPlayerCapturedChick)

        let skyPlayer = Player()
        skyPlayerLion = Piece(.lion, owner: .sky)
        skyPlayer.pieces.append(skyPlayerLion)
        skyPlayerCapturedChick = Piece(.chick, owner: .sky)
        skyPlayer.capturedPieces.append(skyPlayerCapturedChick)

        board.place(groundPlayerLion, at: Position(x: 1, y: 3))
        board.place(skyPlayerLion, at: Position(x: 1, y: 0))

        tested = Game(board: board,
                      groundPlayer: groundPlayer,
                      skyPlayer: skyPlayer)
    }

    override func tearDown() {
        tested = nil
        board = nil
        super.tearDown()
    }

    func test_placingPieceThatIsNotCaptured_throwsError() {
        let newPiece = Piece(.chick, owner: .ground)
        XCTAssertThrowsError(try tested.placeCapturedPiece(newPiece, at: Position(x: 2, y: 3)))
    }

    func test_placingPieceOfNonCurrentPlayer_throwsError() {
        XCTAssertThrowsError(try tested.placeCapturedPiece(skyPlayerCapturedChick, at: Position(x: 1, y: 1)))
    }

    func test_placingPieceOfCurrentPlayer_doesntThrowError() {
        XCTAssertNoThrow(try tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 1)))
    }

    func test_correctPlacingPieceOfCurrentPlayer_changesCurrentPlayer() {
        XCTAssertEqual(.ground, tested.currentPlayer)
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 1))
        XCTAssertEqual(.sky, tested.currentPlayer)
    }

    func test_incorrectPlacingPieceOfCurrentPlayer_doesntChangeCurrentPlayer() {
        XCTAssertEqual(.ground, tested.currentPlayer)
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 3))
        XCTAssertEqual(.ground, tested.currentPlayer)
    }

    func test_placingPiece_increasesNumberOfMoves() {
        let numberOfMoves = tested.numberOfMoves
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 2, y: 3))
        XCTAssertEqual(numberOfMoves + 1, tested.numberOfMoves)
    }

    func test_failedPlacingPiece_doesntIncreaseNumberOfMoves() {
        let numberOfMoves = tested.numberOfMoves
        XCTAssertThrowsError(try tested.placeCapturedPiece(skyPlayerCapturedChick, at: Position(x: 1, y: 1)))
        XCTAssertEqual(numberOfMoves, tested.numberOfMoves)
    }

    func test_placedPiece_isOnTheBoard() {
        let newPosition = Position(x: 1, y: 2)
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: newPosition)
        XCTAssertEqual(newPosition, board.position(of: groundPlayerCapturedChick))
    }

    func test_placingPieceOnOwnPiece_throwsError() {
        XCTAssertThrowsError(try tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 3)))
    }

    func test_placingPieceOnOpponentsPiece_throwsError() {
        XCTAssertThrowsError(try tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 0)))
    }

    func test_placingChickInOpponentsArea_doesntPowerItUp() {
        XCTAssertEqual(.chick, groundPlayerCapturedChick.type)
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 0, y: 0))
        XCTAssertEqual(.chick, groundPlayerCapturedChick.type)
    }

    func test_afterPlacingPiece_itsOwnerRemainsTheSame() {
        XCTAssertEqual(.ground, groundPlayerCapturedChick.owner)
        try? tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 1, y: 2))
        XCTAssertEqual(.ground, groundPlayerCapturedChick.owner)
    }

    func test_afterGameIsWon_placingAPieceThrowsAnError() {
        try? tested.move(groundPlayerLion, to: Position(x: 1, y: 2))
        try? tested.move(skyPlayerLion, to: Position(x: 1, y: 1))
        try? tested.move(groundPlayerLion, to: Position(x: 1, y: 1))
        guard case .finished(_) = tested.state else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try tested.placeCapturedPiece(skyPlayerCapturedChick, at: Position(x: 0, y: 0)))
        XCTAssertThrowsError(try tested.placeCapturedPiece(groundPlayerCapturedChick, at: Position(x: 0, y: 0)))
    }
}
