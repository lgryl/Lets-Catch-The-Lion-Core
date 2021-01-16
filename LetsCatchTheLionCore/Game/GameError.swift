// Created 13/01/2021

import Foundation

public enum GameError: Error {
    case pieceNotFound
    case playOrderViolation
    case capturingOwnPiece
    case illegalMove
    case gameAlreadyFinished
}
