//
//  Player.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated struct Player: Codable, Identifiable, Equatable {
    let id: String
    var socketID: String?
    
    let name: String
    var hand: [Card]
    var handCount: Int?
    var connected: Bool
    var isActive: Bool
    var lastActiveAt: Date?
    let joinedAt: Date
    var score: Int
}
