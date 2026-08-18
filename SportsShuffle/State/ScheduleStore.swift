//
//  ScheduleStore.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/17/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class ScheduleStore {
    private let scheduleProvider: any ScheduleProviding
    
    var schedules: [Schedule] = []
    var isLoading = false
    var error: APIError?
    
    init(scheduleProvider: any ScheduleProviding = APIClient()) {
        self.scheduleProvider = scheduleProvider
    }
        
    func loadSchedules() async {
        isLoading = true
        error = nil
        
        defer {
            isLoading = false
        }
        
        do {
            schedules = try await scheduleProvider.fetchSchedule()
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .unknown
        }
    }
    
}
