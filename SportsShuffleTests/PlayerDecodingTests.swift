//
//  PlayerDecodingTests.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//
import Foundation
import Testing
@testable import SportsShuffle

@Test
func playerDecodesCorrectly() throws {
    let json = """
    {
          "id": "socket-123",
          "socketID": "socket-123",
          "name": "Jennifer",
          "hand": null,
          "handCount": 5,
          "connected": true,
          "isActive": true,
          "lastActiveAt": null,
          "joinedAt": "2026-08-12T13:00:00Z",
          "score": 12
    }
    """
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    let player = try decoder.decode(
        Player.self,
        from: Data(json.utf8)
    )
    
    #expect(player.name == "Jennifer")
    #expect(player.connected == true)
    #expect(player.score == 12)
    #expect(player.hand == nil)
    #expect(player.handCount == 5)
    
    
}

@Test
func missingRequiredNameFailsDecoding() {
    let json = """
    {
      "id": "socket-123",
      "connected": true,
      "isActive": true,
      "joinedAt": "2026-08-12T13:00:00Z",
      "score": 0
    }
    """

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    #expect(throws: DecodingError.self) {
        try decoder.decode(
            Player.self,
            from: Data(json.utf8)
        )
    }
}
