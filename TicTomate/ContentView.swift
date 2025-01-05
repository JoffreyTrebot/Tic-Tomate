//
//  ContentView.swift
//  TicTomate
//
//  Created by Joffrey Trébot on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationState = NavigationState()
    @State private var showTimer = false
    @State private var showSettings = false
    
    var body: some View {
        // Afficher directement PomodoroView pour le développement
        PomodoroView()
        
        // Code original commenté pour référence
        /*
        ZStack {
            if !showTimer {
                HomeView(
                    showSettings: {
                        showSettings = true
                    },
                    showTimer: $showTimer
                )
            } else {
                PomodoroView()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(onBack: { showSettings = false })
        }
        */
    }
}

#Preview {
    ContentView()
}
