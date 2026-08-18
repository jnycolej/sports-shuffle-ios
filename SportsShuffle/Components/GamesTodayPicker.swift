import SwiftUI

struct GamesTodayPicker: View {
    @State private var selectedGame: String?
    @State private var scheduleStore = ScheduleStore()

    var body: some View {
        Group {
            if scheduleStore.isLoading {
                ProgressView("Loading games...")
            } else if let error = scheduleStore.error {
                VStack(spacing: 12) {
                    Text(error.userMessage)

                    Button("Try Again") {
                        Task {
                            await scheduleStore.loadSchedules()
                        }
                    }
                }
            } else if scheduleStore.schedules.isEmpty {
                ContentUnavailableView(
                    "No Games Today",
                    systemImage: "sportscourt",
                    description: Text("There are no scheduled games available right now.")
                )
            } else {
                Picker("Games Today", selection: $selectedGame) {
                    ForEach(scheduleStore.schedules) { game in
                        let matchup = game.teams.joined(separator: " vs ")

                        Text(matchup)
                            .tag(Optional(matchup))
                    }
                }
                .border(.black, width: 1.5)
            }
        }
        .task {
            await scheduleStore.loadSchedules()

            if selectedGame == nil,
               let firstGame = scheduleStore.schedules.first {
                selectedGame = firstGame.teams.joined(separator: " vs ")
            }
        }
    }
}

#Preview {
    GamesTodayPicker()
}
