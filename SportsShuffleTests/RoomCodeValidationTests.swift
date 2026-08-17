//
//  RoomCodeValidationTests.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Testing
@testable import SportsShuffle

@Test
func validRoomCode() throws {
    let result  = try RoomCodeValidator.validate("867fc7")
    #expect(result == "867FC7")
}

@Test
func lowercaseCodeIsNormalized() throws {
    let result = try RoomCodeValidator.validate("867fc7")
    #expect(result == "867FC7")
}

@Test
func emptyCodeFails() {
    #expect(throws: RoomCodeValidationError.empty) {
        try RoomCodeValidator.validate("")
    }
}

