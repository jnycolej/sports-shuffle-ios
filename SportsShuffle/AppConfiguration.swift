//
//  AppConfiguration.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/14/26.
//

import Foundation

nonisolated enum AppConfiguration {

    static var apiBaseURL: URL {
        makeURL(
            schemeKey: "API_SCHEME",
            hostKey: "API_HOST",
            portKey: "API_PORT"
        )
    }

    static var socketBaseURL: URL {
        makeURL(
            schemeKey: "SOCKET_SCHEME",
            hostKey: "SOCKET_HOST",
            portKey: "SOCKET_PORT"
        )
    }

    private static func makeURL(
        schemeKey: String,
        hostKey: String,
        portKey: String
    ) -> URL {
        guard
            let scheme = Bundle.main.object(
                forInfoDictionaryKey: schemeKey
            ) as? String,
            let host = Bundle.main.object(
                forInfoDictionaryKey: hostKey
            ) as? String
        else {
            fatalError("Missing URL configuration")
        }

        var components = URLComponents()
        components.scheme = scheme
        components.host = host

        if let portString = Bundle.main.object(
            forInfoDictionaryKey: portKey
        ) as? String,
           let port = Int(portString) {
            components.port = port
        }

        guard let url = components.url else {
            fatalError("Invalid URL configuration")
        }

        return url
    }
}
