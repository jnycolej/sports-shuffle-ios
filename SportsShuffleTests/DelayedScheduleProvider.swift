//
//  DelayedScheduleProvider.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/18/26.
//

import Testing
@testable import SportsShuffle

final class DelayedScheduleProvider: ScheduleProviding {
    let schedules: [Schedule]
    let delayNanoseconds: UInt64

    init(
        schedules: [Schedule],
        delayNanoseconds: UInt64 = 200_000_000
    ) {
        self.schedules = schedules
        self.delayNanoseconds = delayNanoseconds
    }

    func fetchSchedule() async throws -> [Schedule] {
        try await Task.sleep(nanoseconds: delayNanoseconds)
        return schedules
    }
}

