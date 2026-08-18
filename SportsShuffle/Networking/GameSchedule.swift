//
//  GameSchedule.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import Foundation

extension APIClient: ScheduleProviding {
    func fetchSchedule() async throws -> [Schedule] {
        try await get(
            path: "/api/schedules",
            as: [Schedule].self,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
    }
}
