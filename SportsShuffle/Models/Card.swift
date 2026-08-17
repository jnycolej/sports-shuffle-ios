//
//  Card.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/11/26.
//

import Foundation

nonisolated struct Card: Codable, Equatable, Identifiable {
    var id: String { cardDescription }
    let cardDescription: String
    let penalty: String
    let points: Int
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case cardDescription = "description"
        case penalty
        case points
        case weight
    }
}
