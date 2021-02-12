// Created 16/01/2021

import Foundation

public enum PieceType: String {
    case chick
    case hen
    case giraffe
    case elephant
    case lion
    case cat
    case dog

    var movementRules: MovementRules {
        switch self {
        case .chick:
            return ChickMovementRules()
        case .hen:
            return HenMovementRules()
        case .elephant:
            return ElephantMovementRules()
        case .giraffe:
            return GiraffeMovementRules()
        case .lion:
            return LionMovementRules()
        default:
            return ChickMovementRules()
        }
    }

    mutating func powerUp() {
        switch self {
        case .chick:
            self = .hen
        default:
            return
        }
    }

    mutating func powerDown() {
        switch self {
        case .hen:
            self = .chick
        default:
            return
        }
    }
}
