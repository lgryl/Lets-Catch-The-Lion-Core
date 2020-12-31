// Created 31/12/2020

import Foundation

struct Game {
    let board = Board()
    let player1 = Player()
    let player2 = Player()

    private(set) var currentPlayer: Player

    init() {
        currentPlayer = player1
    }
}
