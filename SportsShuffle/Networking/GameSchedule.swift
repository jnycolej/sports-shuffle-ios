//
//  GameSchedule.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import Foundation

func fetchSchedule() async throws -> [Schedule] {
    let url = URL(string: "http://localhost:8080/api/schedules")!

    var request = URLRequest(url: url)
    request.cachePolicy = .reloadIgnoringLocalCacheData

    print("REQUESTING:", url.absoluteString)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode else {
        throw URLError(.badServerResponse)
    }

    let json = try JSONSerialization.jsonObject(with: data)

    if let schedules = json as? [[String: Any]] {
        print("Number of schedules:", schedules.count)
        print("INDEX 33:", schedules[33])
    }

    return try JSONDecoder().decode([Schedule].self, from: data)
}
