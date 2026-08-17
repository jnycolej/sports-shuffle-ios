//
//  SettingsView.swift
//  SportsShuffle
//
//  Created by Jennifer Joseph on 8/13/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    var body: some View {
        Toggle("Haptics", isOn: $hapticsEnabled)
            .padding()
    }
}

#Preview {
    SettingsView()
}
