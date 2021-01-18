// Created 31/12/2020

import Foundation

internal class Board {
    private var pieces: [[Piece?]]
    private let playerAreaHeight: Int

    public var width: Int {
        pieces.count
    }

    public var height: Int {
        pieces[0].count
    }

    public init(width: Int, height: Int, playerAreaHeight: Int) {
        pieces = Array(repeating: Array(repeating: nil, count: height), count: width)
        self.playerAreaHeight = playerAreaHeight
    }

    public func pieceAt(_ position: Position) -> Piece? {
        guard positionWithinBoard(position) else {
            return nil
        }
        return pieces[position.x][position.y]
    }

    public var allPieces: [Piece] {
        pieces.flatMap { $0 }.compactMap { $0 }
    }

    @discardableResult
    public func place(_ piece: Piece, at position: Position) -> Piece? {
        guard positionWithinBoard(position) else { return nil }

        let previousPiece = pieceAt(position)
        pieces[position.x][position.y] = piece
        return previousPiece
    }

    @discardableResult
    internal func removePieceAt(_ position: Position) -> Piece? {
        guard positionWithinBoard(position) else { return nil }
        let piece = pieceAt(position)
        pieces[position.x][position.y] = nil
        return piece
    }

    private func positionWithinBoard(_ position: Position) -> Bool {
        position.x >= 0 && position.x < width && position.y >= 0 && position.y < height
    }

    @discardableResult
    public func movePiece(from startPosition: Position, to endPosition: Position) throws -> Piece? {
        guard positionWithinBoard(startPosition),
              positionWithinBoard(endPosition) else {
            throw Error.positionOutsideBoard
        }
        guard let piece = pieceAt(startPosition) else {
            throw Error.pieceNotFound
        }
        guard startPosition != endPosition else {
            throw Error.invalidMove
        }
        removePieceAt(startPosition)
        return place(piece, at: endPosition)
    }

    func position(of piece: Piece) -> Position? {
        for x in 0 ..< pieces.count {
            for y in 0 ..< pieces[0].count {
                if piece === pieces[x][y] {
                    return Position(x: x, y: y)
                }
            }
        }
        return nil
    }

    func position(_ position: Position, withinPlayerArea player: PlayerType) -> Bool {
        switch player {
        case .player1:
            return position.y > height - 1 - playerAreaHeight
        case .player2:
            return position.y < playerAreaHeight
        }
    }

    public enum Error: Swift.Error {
        case invalidMove
        case pieceNotFound
        case positionOutsideBoard
    }
}

fileprivate struct BoardVariant {
    var width: Int
    var height: Int
}

public struct Position {
    var x: Int
    var y: Int
}

extension Position: Equatable {}
