//
//  JoinCreateRoomView.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import SwiftUI

struct PlayerNameField: View {
    @Binding var name: String

    var body: some View {
        TextField("Player Name", text: $name)
            .textFieldStyle(.roundedBorder)
    }
}

struct JoinCreateRoomView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var createPlayerName = ""
    @State private var roomCode = "1A2B3CD"
    @State private var joinPlayerName = ""
    @State private var selectedGame = "Saints vs Falcons"
    @State private var games: [Schedule] = []
    
    @State private var socketSpike = SocketSpike()

    var body: some View {
        VStack {
            Text("Sports Shuffle")
                .font(.largeTitle)
            Text("Football - Multiplayer")
                .font(.title)
            HStack {
                PlayerNameField(name: $createPlayerName)
                    .border(.black, width: 1.5)
                    .padding()
                Picker("Games Today", selection: $selectedGame) {
                    ForEach(games) { game in
                        let matchup = game.teams.joined(separator: " vs ")
                        Text(matchup)
                            .tag(matchup)
                    }
                }
                .task {
                    do {
                        games = try await fetchSchedule()
                        //print(games)
                        if let firstGame = games.first {
                            selectedGame = firstGame.teams.joined(separator: " vs ")
                        }
                    } catch {
                        print("Schedule error:", error)
                    }
                }
                .border(.black, width: 1.5)
                NavigationLink("Create Room") {
                    GameLobbyView(
                        playerName: createPlayerName,
                        selectedGame: selectedGame,
                        roomCode: "1A2B3C",
                        players: [
                            Player(
                                id: "socket-1",
                                name: createPlayerName,
                                hand:  [],
                                connected: true,
                                isActive: true,
                                lastActiveAt: nil,
                                joinedAt:Date(),
                                score: 0
                            )
                        ]
                    )
                }
                .buttonStyle(.borderedProminent)
                
            }
            HStack {
                TextField("Room Code", text: $roomCode)
                    .border(.black, width: 1.5)
                    .padding()
                TextField("Player Name", text: $joinPlayerName)
                    .border(Color.black, width: 1.5)
                    .padding()
                
                NavigationLink("Join Room") {
                    GameLobbyView(
                        playerName: joinPlayerName,
                        selectedGame: selectedGame,
                        roomCode: roomCode
                    )
                }
                .buttonStyle(.borderedProminent)
            }
            
            Text("No Room Yet")
                .foregroundStyle(.red)
        }
        .task {
            socketSpike.connect()
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                print("🟢 APP ACTIVE")
            case .inactive:
                print("🟡 APP INACTIVE")
            case .background:
                print("🔴 APP BACKGROUND")
                
            @unknown default:
                break
            }
        }
        .padding()
    }
}


#Preview {
    NavigationStack {
        JoinCreateRoomView()
    }
}
