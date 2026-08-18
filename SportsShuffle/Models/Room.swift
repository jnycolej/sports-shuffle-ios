//
//  Room.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated struct Room: Identifiable, Codable, Equatable {
    var id: String { code }
    
    let code: String
    let gameType: GameType
    let matchup: Matchup
    let createdAt: Date
    
    var startedAt: Date?
    var status: RoomStatus
    var phase: GamePhase
    
    var hostId: String
    var hostKey: String?
    
    //var invite:
    var players: [Player]
    
    let deckMode: String
    //let deckBase: loadDeck(gameType || "football")
    let drawCount: Int
    
    var discardPile: [Card]
    var settings: RoomSettings
}

nonisolated struct RoomSettings: Codable, Equatable {
    let handSize: Int
    let openHandsAllowed: Bool
    let minPlayers: Int
    let version: Int
}

nonisolated struct Matchup: Codable, Equatable {
    let home: String
    let away: String
}

enum GameType: String, Codable {
    case football
    case basketball
    case baseball
}

enum RoomStatus: String, Codable {
    case active
    case inactive
    case waiting
    case completed
}

//func loadDeck(for gameType: GameType) -> [Card] {
//    // ...
//}
