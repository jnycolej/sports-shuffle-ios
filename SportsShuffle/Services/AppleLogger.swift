//
//  AppleLogger.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/17/26.
//

import OSLog

enum AppLogger {
    private static let subsystem =
        Bundle.main.bundleIdentifier ?? "com.sportsshuffle.app"

    private static let socketLogger = Logger(
        subsystem: subsystem,
        category: "socket"
    )

    private static let roomLogger = Logger(
        subsystem: subsystem,
        category: "room"
    )

    private static let gameLogger = Logger(
        subsystem: subsystem,
        category: "game"
    )

    static func socketConnected() {
        socketLogger.info(
            "event=socket_connect result=success"
        )
    }

    static func socketDisconnected() {
        socketLogger.notice(
            "event=socket_disconnect"
        )
    }

    static func reconnectAttempt(_ attempt: Int) {
        socketLogger.info(
            "event=socket_reconnect attempt=\(attempt)"
        )
    }

    static func roomJoined(playerCount: Int) {
        roomLogger.info(
            "event=room_join result=success player_count=\(playerCount)"
        )
    }

    static func roomJoinFailed(errorCode: String) {
        roomLogger.warning(
            "event=room_join result=failure error=\(errorCode)"
        )
    }

    static func gameStarted(playerCount: Int) {
        gameLogger.info(
            "event=game_start result=success player_count=\(playerCount)"
        )
    }
}
