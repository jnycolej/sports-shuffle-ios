//
//  ScheduleLoader.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import Foundation

func fetchMockSchedules() async throws -> [Schedule] {
    try await Task.sleep(for: .seconds(2))

    try Task.checkCancellation()

    return []
}

@MainActor
final class ScheduleLoader {
    var schedules: [Schedule] = []
    var isLoading = false
    var errorMessage: String?

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            schedules = try await fetchMockSchedules()
        } catch is CancellationError {
            errorMessage = "Loading was cancelled."
        } catch {
            errorMessage = "Unable to load schedules."
        }

        isLoading = false
    }
}
