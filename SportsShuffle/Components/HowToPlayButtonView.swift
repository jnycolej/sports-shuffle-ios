//
//  HowToPlayButtonView.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import SwiftUI

struct HowToPlayButtonView: View {
    @State private var showHowToPlay = false
    
    var body: some View {
        Button("How to Play") {
            showHowToPlay = true
        }
        .alert("How to Play", isPresented: $showHowToPlay) {
            Button("OK", role: .cancel) { }
        }    message: {
            Text("TODO")
        }
    }
}

#Preview {
    HowToPlayButtonView()
}
