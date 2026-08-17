//
//  GameLobbyView.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import SwiftUI

struct GameLobbyView: View {
    let playerName: String
    let selectedGame: String
    let roomCode: String
    
    @State private var players: [Player]
    
    @State private var showShareSheet = false
    
    init(
        playerName: String,
        selectedGame: String,
        roomCode: String,
        players: [Player] = []
    ) {
        self.playerName = playerName
        self.selectedGame = selectedGame
        self.roomCode = roomCode
        _players = State(initialValue: players)
    }
    
    var body: some View {
        VStack {
            Text("Sports Shuffle")
                .font(.largeTitle)
            
            Text("\(selectedGame) Game")
                .font(.title)
            
            Text("Lobby")
                .font(.title)
            
            Text("Room Code - \(roomCode)")
                .font(.title2)
            Button("How to Play") {
                
            }
            .buttonStyle(.borderedProminent)
            
            HStack {
                Text("Invite link:")
                Button("Share") {
                    showShareSheet = true
                }
                .sheet(isPresented: $showShareSheet) {
                    Text("Invite to room \(roomCode)")
                }
                Button("Copy") {
                    
                }
                Button("Text") {
                    
                }
            }
            .border(Color.gray, width: 1)
            
            Text("You are the host. Start when ready")
            
            VStack {
//                Text("Players: \(players.count)")
//                List(players) {
//                    player in Text(player.name)
//                }
                Text(playerName)
                
            }
            
            NavigationLink{
                GameScreenView(
                    playerName: playerName,
                    selectedGame: selectedGame,
                    players: players
                )
            } label: {
                Text("Start & Deal")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        GameLobbyView(
            playerName: "Jennifer",
            selectedGame: "Saints vs Falcons",
            roomCode: "1A2B3C",
            players: [
                Player(
                    id: "socket-1",
                    name: "Jennifer",
                    hand: [],
                    connected: true,
                    isActive: true,
                    lastActiveAt: nil,
                    joinedAt: Date(),
                    score: 0
                )
            ]
        )
    }
}
