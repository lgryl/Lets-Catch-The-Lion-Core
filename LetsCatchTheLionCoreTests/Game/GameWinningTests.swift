// Created 23/01/2021

import XCTest
@testable import LetsCatchTheLionCore

class GameWinningTests: XCTestCase {
    private var tested: Game!

    override func setUp() {
        super.setUp()
        tested = Game(gameVariant: .dobutsu)
    }

    override func tearDown() {
        tested = nil
        super.tearDown()
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
}
