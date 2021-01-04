// Created 31/12/2020

import Foundation

public class Board {
    private static let minimumSize = Size(width: 3, height: 4)
    private static let maximumSize = Size(width: 9, height: 9)

    private var pieces: [[Piece?]]

    public var width: Int {
        pieces.count
    }

    public var height: Int {
        pieces[0].count
    }

    public init(width: Int, height: Int) throws {
        guard width >= Self.minimumSize.width,
              height >= Self.minimumSize.height,
              width <= Self.maximumSize.width,
              height <= Self.maximumSize.height else {
            throw Error.invalidSize
        }
        pieces = Array(repeating: Array(repeating: nil, count: height), count: width)
    }

    public init() {
        pieces = Array(repeating: Array(repeating: nil, count: Self.minimumSize.height), count: Self.minimumSize.width)
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
    public func removePieceAt(_ point: Point) -> Piece? {
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

    public enum Error: Swift.Error {
        case invalidSize
        case invalidMove
        case pieceNotFound
        case pointOutsideBoard
    }
}

fileprivate struct Size {
    var width: Int
    var height: Int
}

public struct Point {
    var x: Int
    var y: Int
}

extension Point: Equatable {}
