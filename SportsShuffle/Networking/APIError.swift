//
//  APIError.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/17/26.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case badStatusCode(Int)
    case requestFailed(statusCode: Int)
    case decodingFailed
    case timedOut
    case offline
    case cancelled
    case unknown
}

extension APIError {
    var userMessage: String {
        switch self {
        case .invalidURL:
            return "The app could not connect to the server."
        case .invalidResponse:
            return "The server returned an unexpected response."
        case .badStatusCode(let statusCode):
            if statusCode >= 500 {
                return "The server is having trouble right now. Please try again."
            } else {
                return "The request could not be completed."
            }
        case .requestFailed:
            return "The server could not complete the request."
        case .decodingFailed:
            return "The app could not read the server response"
        case .timedOut:
            return "The request took too long. Please try again"
        case .offline:
            return "You appear to be offline"
        case .cancelled:
            return "The request was cancelled."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}
