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
    
    var body: some View {
        HorizontalNavigationView(currentScreen: $navigationState.currentScreen) {
            HStack(spacing: 0) {
                HomeView(
                    showSettings: {
                        withAnimation {
                            navigationState.currentScreen = .settings
                        }
                    },
                    showTimer: $showTimer
                )
                .frame(width: UIScreen.main.bounds.width)
                
                SettingsView(
                    onBack: {
                        withAnimation {
                            navigationState.currentScreen = .home
                        }
                    }
                )
                .frame(width: UIScreen.main.bounds.width)
            }
        }
        .fullScreenCover(isPresented: $showTimer) {
            PomodoroView()
        }
    }
}

#Preview {
    ContentView()
}
