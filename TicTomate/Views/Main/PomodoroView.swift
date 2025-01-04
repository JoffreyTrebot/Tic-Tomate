import SwiftUI

struct PomodoroView: View {
    @StateObject private var viewModel = PomodoroViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
        .sheet(isPresented: $viewModel.showSettings) {
            SettingsView(onBack: { viewModel.showSettings = false })
        }
    }
}

#Preview {
    PomodoroView()
} 