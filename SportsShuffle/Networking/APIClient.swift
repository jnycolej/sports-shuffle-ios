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
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
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

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw mapNetworkError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw APIError.badStatusCode(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
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
}
