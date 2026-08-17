//
//  GamesTodayPicker.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import SwiftUI


struct GamesTodayPicker: View {
    @State private var selectedGame = "Saints vs Falcons"

    var body: some View {
        

        Picker("Games Today", selection: $selectedGame) {

            Text("Saints vs Falcons")
                .tag("Saints vs Falcons")
            Text("Cowboys vs Eagles")
                .tag("Cowboys vs Eagles")
        }
        .task {
            do {
                let games = try await fetchSchedule()
                print(games)
            } catch {
                print("Schedule error:", error)
            }
        }
        .border(.black, width: 1.5)
    }
}


#Preview {
    GamesTodayPicker()
}
