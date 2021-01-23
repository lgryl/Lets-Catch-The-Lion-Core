// Created 31/12/2020

import XCTest
@testable import LetsCatchTheLionCore

class GameTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
    }

    func test_defaultGameCrearted_boardShouldBe3TilesWide() {
        let board = tested.board
        XCTAssertEqual(3, board.width)
    }

    func test_defaultGameCrearted_boardShouldBe4TilesHigh() {
        let board = tested.board
        XCTAssertEqual(4, board.height)
    }

    func test_forNewGame_groundPlayerShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .ground).isEmpty)
    }

    func test_forNewGame_skyPlayerShouldNotHaveAnyCapturedPieces() {
        XCTAssertTrue(tested.capturedPieces(of: .sky).isEmpty)
    }

    func test_forNewGame_currentPlayerShouldBeGroundPlayer() {
        let currentPlayer = tested.currentPlayer
        XCTAssertTrue(currentPlayer == .ground)
    }

    func test_newDobutsuGame_groundPlayerShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .ground).count)
    }

    func test_newDobutsuGame_skyPlayerShouldHave4Pieces() {
        tested = Game(gameVariant: .dobutsu)
        XCTAssertEqual(4, tested.pieces(of: .sky).count)
    }

    func test_newGoroGoroGame_groundPlayerShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .ground).count)
    }

    func test_newGoroGoroGame_skyPlayerShouldHave8Pieces() {
        tested = Game(gameVariant: .goroGoro)
        XCTAssertEqual(8, tested.pieces(of: .sky).count)
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

    func test_beforeAnyMoves_gameIsOngoing() {
        guard case GameState.ongoing(_) = tested.state else {
            XCTFail()
            return
        }
    }

    func test_whenPlayers2LionIsCaptured_groundPlayerWins() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 1, y: 2))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(groundLion, to: Position(x: 1, y: 1))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.ground, winner)
        } else {
            XCTFail()
        }
    }

    func test_whenPlayers1LionIsCaptured_skyPlayerWins() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 1, y: 2))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(groundLion, to: Position(x: 2, y: 2))
        try tested.move(skyLion, to: Position(x: 2, y: 2))
        if case let GameState.finished(winner) = tested.state {
            XCTAssertEqual(.sky, winner)
        } else {
            XCTFail()
        }
    }

    func test_moveAfterVictory_throwsException() throws {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 1, y: 2))
        let skyChick = Piece(.chick, owner: .sky)
        board.place(skyChick, at: Position(x: 1, y: 0))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 1, y: 1))
        tested = Game(board: board)

        try tested.move(groundLion, to: Position(x: 1, y: 1))
        XCTAssertThrowsError(try tested.move(skyChick, to: Position(x: 1, y: 1)))
    }

    func test_whenGroundPlayerLionReachesOpponentsArea_groundPlayerWins() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 0, y: 1))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 2, y: 2))
        tested = Game(board: board)
        do {
            try tested.move(groundLion, to: Position(x: 0, y: 0))
            guard case let .finished(winner) = tested.state else {
                XCTFail()
                return
            }
            guard winner == .ground else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }

    func test_afterGroundPlayerLionReachesOpponentsAreaAndCanBeCaptured_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 0, y: 1))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 1, y: 0))
        tested = Game(board: board)
        do {
            try tested.move(groundLion, to: Position(x: 0, y: 0))
            guard case let .ongoing(currentPlayer) = tested.state else {
                XCTFail()
                return
            }
            guard currentPlayer == .sky else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }

    func test_afterSkyPlayerLionReachesOpponentsAreaAndCanBeCaptured_gameContinues() {
        let board = Board(width: 3, height: 4, playerAreaHeight: 1)
        let groundLion = Piece(.lion, owner: .ground)
        board.place(groundLion, at: Position(x: 1, y: 2))
        let skyLion = Piece(.lion, owner: .sky)
        board.place(skyLion, at: Position(x: 2, y: 2))
        tested = Game(board: board)
        do {
            try tested.move(groundLion, to: Position(x: 1, y: 3))
            try tested.move(skyLion, to: Position(x: 2, y: 3))
            guard case let .ongoing(currentPlayer) = tested.state else {
                XCTFail()
                return
            }
            guard currentPlayer == .ground else {
                XCTFail()
                return
            }
        } catch {
            XCTFail()
        }
    }

    func test_whenGroundPlayerNonLionReachesOpponentArea_gameContinues() throws {
        let groundChick = Piece(.chick, owner: .ground)
        let skyChick = Piece(.chick, owner: .sky)
        tested = createGame(with: (piece: groundChick, position: Position(x: 0, y: 1)),
                                (piece: skyChick, position: Position(x: 2, y: 1)))
        try tested.move(groundChick, to: Position(x: 0, y: 0))
        guard case let .ongoing(currentPlayer) = tested.state else {
            XCTFail()
            return
        }
        XCTAssertEqual(.sky, currentPlayer)
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

    func test_placingPieceThatIsNotCaptured_throwsError() {
        let newPiece = Piece(.chick, owner: .ground)
        XCTAssertThrowsError(try tested.placeCapturedPiece(newPiece, at: Position(x: 2, y: 3)))
    }

    private func createGame(boardWidth: Int = 3,
                             boardHeight: Int = 4,
                             playerAreaHeight: Int = 1,
                             with piecesAndPositions: (piece: Piece, position: Position)...) -> Game {
        let board = Board(width: boardWidth,
                          height: boardHeight,
                          playerAreaHeight: playerAreaHeight)
        for pair in piecesAndPositions {
            board.place(pair.piece, at: pair.position)
        }
        let game = Game(board: board)

        return game
    }
}
