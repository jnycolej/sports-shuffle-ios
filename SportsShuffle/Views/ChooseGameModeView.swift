//
//  ChooseGameMode.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/12/26.
//

import SwiftUI

struct ChooseGameModeView: View {
    @Environment(\.colorScheme)
    private var colorScheme
    
    @State private var showHowToPlay = false

    var body: some View {
        VStack {
            Text("Football")
                .font(.title)
            
            Text("Choose Game Mode")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                NavigationLink {
                    JoinCreateRoomView()
                } label: {
                    Label("Multiplayer", systemImage: "person.3.fill")
                }
                .foregroundStyle(Color(.label))
                
                NavigationLink {
                    // SinglePlayerView()
                } label: {
                    Label("Single Player", systemImage: "person.fill")
                }
            }
            HowToPlayButtonView()
            .padding(20)
        }
    }
}


#Preview {
    ChooseGameModeView()
}
