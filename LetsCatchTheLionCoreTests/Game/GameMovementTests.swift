// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class GameMovementTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_afterInvalidMove_currentPlayerIsStillGroundPlayer() {
        XCTAssertTrue(tested.currentPlayer == .ground)
        guard let piece = tested.board.pieceAt(Position(x: 1, y: 2)),
              piece.type == .chick else {
            XCTFail()
            return
        }
        _ = try? tested.move(piece, to: Position(x: 1, y: 2))
        XCTAssertTrue(tested.currentPlayer == .ground)
    }

    func test_afterValidMove_currentPlayerIsSkyPlayer() {
        XCTAssertTrue(tested.currentPlayer == .ground)
        guard let piece = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece.type == .giraffe else {
            XCTFail()
            return
        }
        _ = try? tested.move(piece, to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .sky)
    }

    func test_after2ValidMoves_currentPlayerIsGroundPlayerAgain() {
        XCTAssertTrue(tested.currentPlayer == .ground)
        guard let piece1 = tested.board.pieceAt(Position(x: 2, y: 3)),
              piece1.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.ground, piece1.owner)
        _ = try? tested.move(piece1, to: Position(x: 2, y: 2))
        XCTAssertTrue(tested.currentPlayer == .sky)

        guard let piece2 = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece2.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.sky, piece2.owner)
        _ = try? tested.move(piece2, to: Position(x: 0, y: 1))
        XCTAssertTrue(tested.currentPlayer == .ground)
    }

    func test_movingPieceOfNonCurrentPlayer_throwsException() {
        XCTAssertTrue(tested.currentPlayer == .ground)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.sky, piece.owner)
        XCTAssertThrowsError(try tested.move(piece, to: Position(x: 0, y: 1)))
    }

    func test_movingPieceNotBelongingToCurrentPlayer_throwsException() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        tested = Game(board: board)
        let piece = Piece(.chick, owner: .ground)
        board.place(piece, at: Position(x: 2, y: 2))
        XCTAssertThrowsError(try tested.move(piece, to: Position(x: 2, y: 1)))
    }

    func test_afterMovingPieceOfNonCurrentPlayer_turnDoesntChange() {
        XCTAssertTrue(tested.currentPlayer == .ground)
        guard let piece = tested.board.pieceAt(Position(x: 0, y: 0)),
              piece.type == .giraffe else {
            XCTFail()
            return
        }
        XCTAssertEqual(.sky, piece.owner)
        XCTAssertTrue(tested.currentPlayer == .ground)
    }

    func test_afterMovingPieceIntoOpponentsPiece_pieceIsCaptured() {
        guard let capturedPiece = tested.board.pieceAt(Position(x: 1, y: 1)) else {
            XCTFail()
            return
        }
        try? tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(1, tested.capturedPieces(of: .ground).count)
        XCTAssertTrue(capturedPiece === tested.capturedPieces(of: .ground)[0])
        XCTAssertEqual(3, tested.pieces(of: .sky).count)
    }

    func test_afterCapturingPiece_pieceChangesOwner() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        board.place(Piece(.chick, owner: .sky), at: Position(x: 1, y: 1))
        board.place(Piece(.chick, owner: .ground), at: Position(x: 1, y: 2))
        tested = Game(board: board)

        guard let capturedPiece = tested.board.pieceAt(Position(x: 1, y: 1)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(.sky, capturedPiece.owner)
        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(.ground, capturedPiece.owner)
    }

    func test_movingPieceOnOwnPiece_throwsException() {
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 3), to: Position(x: 1, y: 2)))
    }

    func test_movingPieceOnOwnPiece_doesntChangeCurrentPlayer() {
        XCTAssertEqual(.ground, tested.currentPlayer)
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 3), to: Position(x: 1, y: 2)))
        XCTAssertEqual(.ground, tested.currentPlayer)
    }

    func test_beforeAnyMove_numberOfMovesIsZero() {
        XCTAssertEqual(0, tested.numberOfMoves)
    }

    func test_afterValidMove_numberOfMovesIncreases() throws {
        try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 1))
        XCTAssertEqual(1, tested.numberOfMoves)
    }
    
    func test_afterInvalidMove_numberOfMovesDoesntIncrease() throws {
        XCTAssertThrowsError(try tested.move(from: Position(x: 1, y: 2), to: Position(x: 1, y: 2)))
        XCTAssertEqual(0, tested.numberOfMoves)
    }

    func test_movingPieceViolatingItsMoveRules_throwsException() {
        XCTAssertThrowsError(try tested.move(from: Position(x: 0, y: 3), to: Position(x: 0, y: 2)))
    }

    func test_whenChickReachesOpponentsArea_itCanGoBack() throws {
        let groundChick = Piece(.chick, owner: .ground)
        let skyChick = Piece(.chick, owner: .sky)
        tested = createGame(with: (piece: groundChick, position: Position(x: 0, y: 1)),
                                (piece: skyChick, position: Position(x: 2, y: 1)))
        XCTAssertThrowsError(try tested.move(groundChick, to: Position(x: 0, y: 2)))
        try tested.move(groundChick, to: Position(x: 0, y: 0))
        try tested.move(skyChick, to: Position(x: 2, y: 2))
        XCTAssertNoThrow(try tested.move(groundChick, to: Position(x: 0, y: 1)))
    }

    func test_whenChickReachesOpponentsArea_itBecamesHen() throws {
        let groundChick = Piece(.chick, owner: .ground)
        let skyChick = Piece(.chick, owner: .sky)
        tested = createGame(with: (piece: groundChick, position: Position(x: 0, y: 1)),
                                (piece: skyChick, position: Position(x: 2, y: 1)))
        XCTAssertEqual(.chick, groundChick.type)
        try tested.move(groundChick, to: Position(x: 0, y: 0))
        XCTAssertEqual(.hen, groundChick.type)
    }

    func test_whenHenIsCaptured_itBecamesChick() throws {
        let groundChick = Piece(.chick, owner: .ground)
        let skyHen = Piece(.hen, owner: .sky)
        tested = createGame(with: (piece: groundChick, position: Position(x: 1, y: 2)),
                                (piece: skyHen, position: Position(x: 1, y: 1)))

        XCTAssertEqual(.hen, skyHen.type)
        try tested.move(groundChick, to: Position(x: 1, y: 1))
        XCTAssertEqual(.chick, skyHen.type)
    }
}
