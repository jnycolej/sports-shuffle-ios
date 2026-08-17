//
//  GamePhase.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated enum GamePhase: String, Codable {
    case lobby
    case dealing
    case playing
    case voting
    case completing
}
