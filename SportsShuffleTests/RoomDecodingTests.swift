//
//  RoomDecodingTests.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Foundation
import Testing
@testable import SportsShuffle

@Test
func validRoom() throws {
    let json = """
    {
      "code": "86T59D",
      "gameType": "football",
      "matchup": {
        "home": "LSU",
        "away": "Clemson"
      },
      "createdAt": "2026-08-12T14:00:00Z",
      "startedAt": null,
      "status": "active",
      "phase": "lobby",
      "hostId": "socket-123",
      "hostKey": null,
      "players": [],
      "deckMode": "standard",
      "drawCount": 1,
      "discardPile": [],
      "settings": {
        "handSize": 5,
        "openHandsAllowed": false,
        "minPlayers": 2,
        "version": 1
      }
    }
    """

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    let room = try decoder.decode(
        Room.self,
        from: Data(json.utf8)
    )

    #expect(room.code == "86T59D")
    #expect(room.gameType == .football)
    #expect(room.matchup.home == "LSU")
    #expect(room.matchup.away == "Clemson")
    #expect(room.status == .active)
    #expect(room.phase == .lobby)
    #expect(room.players.isEmpty)
    #expect(room.settings.handSize == 5)
}
