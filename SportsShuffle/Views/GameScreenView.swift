//
//  GameScreenView.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import SwiftUI

struct GameScreenView: View {
    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion
    
    let playerName: String
    let selectedGame: String
    let players: [Player]
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]

    @State private var selectedReaction: String?
    
    var body: some View {
        VStack {
            Text("Sports Shuffle")
                .font(.largeTitle)
            Text("Football Game")
                .font(.title2)
            VStack {
                Text("Scoreboard")
                    .font(.title)
                Text(selectedGame)
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        ForEach(players) { player in
                            Text("\(player.name) \(player.score) pts")
                                .font(.headline)
                                .border(Color.gray, width: 1)
                        }
                    }
                }
                .border(Color.gray, width: 1)
                .padding(20)
            }
            VStack(spacing : 10){
                Text("Play-by-Play")
                    .font(.title)
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        Text("Play 1")
                        Text("Play 2")
                        Text("Play 3")
                    }
                    .font(.headline)
                }

            }
            Button("How to Play") {
                
            }
            .buttonStyle(.borderedProminent)

            VStack {
                Text("Quick Reacts")
                    .font(.title)
                HStack {
                    Button("🔥 Nice") { selectedReaction = "Nice"}
                    Button("😂 Lucky") { selectedReaction = "Lucky"}
                    Button("😤 Rigged") { selectedReaction = "Rigged"}
                    Button("💀 Brutal") { selectedReaction = "Brutal"}
                }
                .buttonStyle(.borderedProminent)
                if let selectedReaction {
                    Text("Reaction: \(selectedReaction)")
                }
            }
            VStack {
                Text("Quick Points")
                    .font(.title)
                HStack {
                    Button("Touchdown") { }
                    Button("Interception") { }
                    Button("Fumble") { }
                    Button("Big Play \n 20+ yards") { }
                }
                .buttonStyle(.borderedProminent)
            }
            VStack {
                Text("\(playerName)'s Hand")
                    .font(.title)
                Text("Points: 0")
                    .font(.headline)
                HStack {
                    if let currentPlayer = players.first(where: { $0.name == playerName }) {
                        ForEach(currentPlayer.hand) { card in
                            Text(card.cardDescription)
                        }
                    }
                }
            }
            VStack {
                Text("Player 2's Hand")
                    .font(.title)
                Text("Points: 0")
                    .font(.headline)
                HStack {
                    Text("Card 1")
                    Text("Card 2")
                    Text("Card 3")
                    Text("Card 4")
                    Text("Card 5")
                }
            }

        }
        NavigationLink("Leave Game"){
            ChooseGameModeView()
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color.red)
    }
}

#Preview {
    NavigationStack{
        GameScreenView(
            playerName: "Jennifer",
            selectedGame: "Saints vs Falcons",
            players: [
                Player(
                    id: "socket-1",
                    name: "Jennifer",
                    hand: [
                        Card(
                            cardDescription: "Touchdown",
                            penalty: "",
                            points: 6,
                            weight: 1
                        ),
                        Card(
                            cardDescription: "Field Goal",
                            penalty: "",
                            points: 3,
                            weight: 1
                        )
                    ],
                    connected: true,
                    isActive: true,
                    lastActiveAt: nil,
                    joinedAt: Date(),
                    score: 0
                )
            ],
            
        )
    }
}
