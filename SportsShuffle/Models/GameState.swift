//
//  GameState.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated struct GameState: Codable {
    let code: String
    let gameType: GameType
    let matchup: Matchup?
    let team: String?
    let phase: GamePhase
    let hostId: String?
    let players: [Player]
    let deckCount: Int?
    let discardCount: Int?
    
}
