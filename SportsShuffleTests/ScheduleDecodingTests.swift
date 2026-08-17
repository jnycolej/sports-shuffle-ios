//
//  ScheduleDecodingTests.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Foundation
import Testing
@testable import SportsShuffle

@Test
func validScheduledGame() throws {
    let json = """
    {
      "teams": ["LSU", "Clemson"],
      "league": "NCAA",
      "conferences": ["SEC", "ACC"],
      "sport": "football",
      "date": "2026-09-05",
      "time": "6:30pm CT",
      "networks": ["ABC"],
      "tag": ["regular"]
    }
    """
    
    let game = try JSONDecoder().decode(
          Schedule.self,
          from: Data(json.utf8)
      )

    #expect(game.sport == .football)
    #expect(game.date == "2026-09-05")
    #expect(game.teams == ["LSU", "Clemson"])
    #expect(game.league == .ncaa)
    #expect(game.conferences == [.sec, .acc])
    #expect(game.networks == [.abc])
    #expect(game.tag == [.regular])
    
}

@Test
func invalidEnumValue() throws {
    let json = """
    {
      "teams": ["LSU", "Clemson"],
      "league": "NCAA",
      "conferences": ["SEC", "ACC"],
      "sport": "soccer",
      "date": "2026-09-05",
      "time": "6:30pm CT",
      "networks": ["ABC"],
      "tag": ["regular"]
    }
    """
    
    let game = try JSONDecoder().decode(
          Schedule.self,
          from: Data(json.utf8)
      )
    
    #expect(throws: DecodingError.self) {
        try JSONDecoder().decode(
            Schedule.self,
            from: Data(json.utf8)
        )
    }
}
