import SwiftUI

struct PomodoroView: View {
    @StateObject private var viewModel = PomodoroViewModel()
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            if isLandscape {
                // Layout horizontal
                HStack(spacing: 0) {
                    // Timer en plein écran
                    FlipClockView(timeString: viewModel.timeRemainingText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.leading, 20)
                    
                    // Boutons alignés verticalement à droite
                    VStack(spacing: 40) {
                        Spacer()
                        
                        Button(action: viewModel.reset) {
                            Image(systemName: "arrow.counterclockwise")
                                .controlButtonStyle()
                        }
                        
                        Button(action: viewModel.toggleTimer) {
                            Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                                .controlButtonStyle()
                        }
                        
                        Button(action: viewModel.openSettings) {
                            Image(systemName: "gear")
                                .controlButtonStyle()
                        }
                        
                        Spacer()
                    }
                    .frame(width: 100) // Largeur fixe pour la colonne des boutons
                    .padding(.horizontal)
                    .background(Color(.systemGray6).opacity(0.5))
                }
            } else {
                // Layout vertical (existant)
                VStack {
                    Spacer()
                    
                    FlipClockView(timeString: viewModel.timeRemainingText)
                        .padding(40)
                    
                    Spacer()
                    
                    ControlButtonsView(
                        isRunning: viewModel.isRunning,
                        onReset: viewModel.reset,
                        onToggle: viewModel.toggleTimer,
                        onSettings: viewModel.openSettings
                    )
                    .padding(.bottom, 30)
                }
            }
        }
        .sheet(isPresented: $viewModel.showSettings) {
            SettingsView(onBack: { viewModel.showSettings = false })
        }
    }
}

// Previews
#Preview("Portrait") {
    PomodoroView()
}

#Preview("Landscape", traits: .landscapeLeft) {
    PomodoroView()
} 