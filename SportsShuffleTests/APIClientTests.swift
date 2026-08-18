//
//  APIClientTests.swift
//  SportsShuffleTests
//
//  Created by Jennifer Joseph on 8/17/26.
//

import Testing
import Foundation
@testable import SportsShuffle

struct APIClientTests {

    private func makeSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        return URLSession(configuration: configuration)
    }
    
    @Test func fetchScheduleDecodesSuccessfulResponse() async throws {
        let json = """
            [
                {
                    "teams": ["Saints", "Falcons"],
                    "league": "NFL",
                    "conferences": ["NFC-South"],
                    "sport": "football",
                    "date": "2026-08-17",
                    "time": "19:00",
                    "networks": ["FOX"],
                    "tag": ["regular"]
                }
            ]
            """
        
        MockURLProtocol.requestHandler = { request in
            #expect(request.url?.path == "/api/schedules")
            #expect(request.httpMethod == "GET")
            
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (
                response,
                Data(json.utf8)
            )
        }
        
        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )
        
        let schedules = try await client.fetchSchedule()
        
        #expect(schedules.count == 1)
        #expect(schedules[0].teams == ["Saints", "Falcons"])
        #expect(schedules[0].league == .nfl)
        #expect(schedules[0].sport == .football)
    }
    
    @Test
    func fetchScheduleCanReturnEmptyList() async throws {
        MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                )!
            
            return (
                response,
                Data("[]".utf8)
            )
        }
        
        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )
        
        let schedules = try await client.fetchSchedule()
        
        #expect(schedules.isEmpty)
    }

    @Test
    func fetchScheduleMapsServerError() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (
                response,
                Data()
            )
        }
        
        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )
        
        do {
            _ = try await client.fetchSchedule()
            Issue.record("Expected request to throw")
        } catch let error as APIError {
            #expect(error == .badStatusCode(500))
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
    
    @Test
    func fetchScheduleMapsOfflineError() async {
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }
        
        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )
        
        do {
            _ = try await client.fetchSchedule()
            Issue.record("Expected request to throw")
        } catch let error as APIError {
            #expect(error == .offline)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
    
    @Test
    func fetchScheduleMapsDecodingFailure() async {
        let invalidJSON = """
        {
            "unexpected": "shape"
        }
        """

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            return (
                response,
                Data(invalidJSON.utf8)
            )
        }

        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )

        do {
            _ = try await client.fetchSchedule()
            Issue.record("Expected decoding failure")
        } catch let error as APIError {
            #expect(error == .decodingFailed)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
    
    @Test
    func fetchScheduleMapsCancellation() async {
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.cancelled)
        }

        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )

        do {
            _ = try await client.fetchSchedule()
            Issue.record("Expected cancellation")
        } catch let error as APIError {
            #expect(error == .cancelled)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
    
    @Test
    func fetchScheduleRetriesTransientServerFailure() async throws {
        var requestCount = 0

        MockURLProtocol.requestHandler = { request in
            requestCount += 1

            if requestCount == 1 {
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: 503,
                    httpVersion: nil,
                    headerFields: nil
                )!

                return (response, Data())
            }

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            return (
                response,
                Data("[]".utf8)
            )
        }

        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )

        let schedules = try await client.fetchSchedule()

        #expect(requestCount == 2)
        #expect(schedules.isEmpty)
    }
    
    @Test
    func fetchScheduleDoesNotRetryCancellation() async {
        var requestCount = 0

        MockURLProtocol.requestHandler = { _ in
            requestCount += 1
            throw URLError(.cancelled)
        }

        let client = APIClient(
            baseURL: URL(string: "https://example.test")!,
            session: makeSession()
        )

        do {
            _ = try await client.fetchSchedule()
            Issue.record("Expected cancellation")
        } catch let error as APIError {
            #expect(error == .cancelled)
            #expect(requestCount == 1)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}
