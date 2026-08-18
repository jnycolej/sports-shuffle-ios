//
//  ScheduleProviding.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/18/26.
//

import Foundation

protocol ScheduleProviding {
    func fetchSchedule() async throws -> [Schedule]
}
