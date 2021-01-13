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

    public func pieceAt(_ point: Point) -> Piece? {
        guard pointWithinBoard(point) else {
            return nil
        }
        return pieces[point.x][point.y]
    }

    @discardableResult
    public func place(_ piece: Piece, at point: Point) -> Piece? {
        guard pointWithinBoard(point) else { return nil }

        let previousPiece = pieceAt(point)
        pieces[point.x][point.y] = piece
        return previousPiece
    }

    @discardableResult
    internal func removePieceAt(_ point: Point) -> Piece? {
        guard pointWithinBoard(point) else { return nil }
        let piece = pieceAt(point)
        pieces[point.x][point.y] = nil
        return piece
    }

    private func pointWithinBoard(_ point: Point) -> Bool {
        point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
    }

    @discardableResult
    public func movePiece(from startPoint: Point, to endPoint: Point) throws -> Piece? {
        guard pointWithinBoard(startPoint),
              pointWithinBoard(endPoint) else {
            throw Error.pointOutsideBoard
        }
        guard let piece = pieceAt(startPoint) else {
            throw Error.pieceNotFound
        }
        guard startPoint != endPoint else {
            throw Error.invalidMove
        }
        removePieceAt(startPoint)
        return place(piece, at: endPoint)
    }

    func position(of piece: Piece) -> Point? {
        for x in 0 ..< pieces.count {
            for y in 0 ..< pieces[0].count {
                if piece === pieces[x][y] {
                    return Point(x: x, y: y)
                }
            }
        }
        return nil
    }

    func point(_ point: Point, withinPlayerArea player: PlayerType) -> Bool {
        switch player {
        case .player1:
            return point.y > height - 1 - playerAreaHeight
        case .player2:
            return point.y < playerAreaHeight
        }
    }

    public enum Error: Swift.Error {
        case invalidMove
        case pieceNotFound
        case pointOutsideBoard
    }
}

fileprivate struct BoardVariant {
    var width: Int
    var height: Int
}

public struct Point {
    var x: Int
    var y: Int
}

extension Point: Equatable {}
