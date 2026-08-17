//
//  SocketSpike.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import Foundation
import SocketIO

final class SocketSpike {
    private let manager: SocketManager
    private let socket: SocketIOClient
    
    
    init() {
        let socketURL = AppConfiguration.socketBaseURL

        manager = SocketManager(
            socketURL: socketURL,
            config: [
                .log(true),
                .compress
            ]
        )

        socket = manager.defaultSocket
    }

    func connect() {
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("✅ SOCKET CONNECTED")
            
            self?.joinRoom(code: "YOUR-REAL-ROOM-CODE", displayName: "Jennifer")
        }

        socket.on(clientEvent: .disconnect) { data, ack in
            print("❌ SOCKET DISCONNECTED")
            print(data)
        }

        socket.on(clientEvent: .error) { data, ack in
            print("⚠️ SOCKET ERROR")
            print(data)
        }

        socket.connect(withPayload: [
            "protocolVersion": 1
        ])
    }
    func joinRoom(code: String, displayName: String) {
        let payload: [String: Any] = [
            "roomCode": code,
            "displayName": displayName
        ]
        
        socket.emitWithAck("room:join", payload)
            .timingOut(after: 5) { data in
                print("ROOM JOIN ACK:", data)
            }
    }
}
