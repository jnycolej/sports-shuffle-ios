//
//  MockScheduleProvider.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/18/26.
//

import Testing

@testable import SportsShuffle

final class MockScheduleProvider: ScheduleProviding {
    var result: Result<[Schedule], Error>

    init(result: Result<[Schedule], Error>) {
        self.result = result
    }

    func fetchSchedule() async throws -> [Schedule] {
        try result.get()
    }
}
