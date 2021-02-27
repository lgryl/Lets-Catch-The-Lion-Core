// Created 12/02/2021

import Foundation

internal struct BoardConfigurationFactory {
    static func configuration(for variant: GameVariant) -> BoardConfiguration {
        switch variant {
        case .dobutsu:
            return BoardConfiguration(width: 3,
                                      height: 4,
                                      playerAreaHeight: 1,
                                      piecesArrangement: DobutsuPiecesArrangement())
        case .goroGoro:
            return BoardConfiguration(width: 5,
                                      height: 6,
                                      playerAreaHeight: 2,
                                      piecesArrangement: GoroGoroPiecesArrangement())
        }
    }
}
