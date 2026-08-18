//
//  ScheduleStoreTests.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/18/26.
//

import Testing
@testable import SportsShuffle

@MainActor
struct ScheduleStoreTests {

    @Test
    func loadSchedulesStoresSuccessfulResponse() async {
        let schedule = Schedule(
            teams: ["Saints", "Falcons"],
            league: .nfl,
            conferences: [.nfcSouth],
            sport: .football,
            date: "2026-08-18",
            time: "19:00",
            networks: [.fox],
            tag: [.regular]
        )

        let mock = MockScheduleProvider(
            result: .success([schedule])
        )

        let store = ScheduleStore(
            scheduleProvider: mock
        )

        await store.loadSchedules()

        #expect(store.schedules.count == 1)
        #expect(store.schedules[0].teams == ["Saints", "Falcons"])
        #expect(store.error == nil)
        #expect(store.isLoading == false)
    }
    
    @Test
    func loadSchedulesHandlesEmptyResponse() async {
        let mock = MockScheduleProvider(
            result: .success([])
        )

        let store = ScheduleStore(
            scheduleProvider: mock
        )

        await store.loadSchedules()

        #expect(store.schedules.isEmpty)
        #expect(store.error == nil)
        #expect(store.isLoading == false)
    }
    
    @Test
    func loadSchedulesStoresOfflineError() async {
        let mock = MockScheduleProvider(
            result: .failure(APIError.offline)
        )

        let store = ScheduleStore(
            scheduleProvider: mock
        )

        await store.loadSchedules()

        #expect(store.schedules.isEmpty)
        #expect(store.error == .offline)
        #expect(store.isLoading == false)
    }
    
    @Test
    func loadSchedulesShowsLoadingWhileRequestIsRunning() async {
        let mock = DelayedScheduleProvider(
            schedules: []
        )

        let store = ScheduleStore(
            scheduleProvider: mock
        )

        let task = Task {
            await store.loadSchedules()
        }

        await Task.yield()

        #expect(store.isLoading == true)

        await task.value

        #expect(store.isLoading == false)
    }
    
    @Test
    func loadSchedulesStoresServerError() async {
        let mock = MockScheduleProvider(
            result: .failure(APIError.badStatusCode(500))
        )

        let store = ScheduleStore(
            scheduleProvider: mock
        )

        await store.loadSchedules()

        #expect(store.schedules.isEmpty)
        #expect(store.error == .badStatusCode(500))
        #expect(store.isLoading == false)
    }
}
