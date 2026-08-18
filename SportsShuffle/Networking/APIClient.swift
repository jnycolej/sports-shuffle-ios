import Foundation

nonisolated final class APIClient {
    private let session: URLSession
    private let baseURL: URL

    init(
        baseURL: URL = AppConfiguration.apiBaseURL,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    func get<T: Decodable>(
        path: String,
        as type: T.Type,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        retries: Int = 1
    ) async throws -> T {
        guard let url = URL(
            string: path,
            relativeTo: baseURL
        ) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.cachePolicy = cachePolicy

        var attempt = 0

        while true {
            do {
                let (data, response) = try await session.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                guard 200...299 ~= httpResponse.statusCode else {
                    let error = APIError.badStatusCode(httpResponse.statusCode)

                    if attempt < retries && shouldRetry(error) {
                        attempt += 1
                        continue
                    }

                    throw error
                }

                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw APIError.decodingFailed
                }

            } catch let apiError as APIError {
                if attempt < retries && shouldRetry(apiError) {
                    attempt += 1
                    continue
                }

                throw apiError

            } catch {
                let apiError = mapNetworkError(error)

                if attempt < retries && shouldRetry(apiError) {
                    attempt += 1
                    continue
                }

                throw apiError
            }
        }
    }

    private func mapNetworkError(_ error: Error) -> APIError {
        if error is CancellationError {
            return .cancelled
        }

        guard let urlError = error as? URLError else {
            return .unknown
        }

        switch urlError.code {
        case .notConnectedToInternet,
             .networkConnectionLost:
            return .offline

        case .timedOut:
            return .timedOut

        case .cancelled:
            return .cancelled

        default:
            return .unknown
        }
    }
    
    private func shouldRetry(_ error: APIError) -> Bool {
        switch error {
        case .timedOut,
                .offline:
            return true
            
        case .badStatusCode(let statusCode):
            return statusCode == 502 ||
            statusCode == 503 ||
            statusCode == 504
            
        case .invalidURL,
                .invalidResponse,
                .decodingFailed,
                .cancelled,
                .unknown:
            return false
        }
    }
}
