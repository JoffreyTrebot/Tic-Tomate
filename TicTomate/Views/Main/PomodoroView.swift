import SwiftUI

struct PomodoroView: View {
    @StateObject private var viewModel = PomodoroViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showStopConfirmation = false
    
    var body: some View {
        LandscapeView {
            ZStack {
                // Timer
                FlipClockView(timeString: viewModel.timeRemainingText)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .safeAreaInset(edge: .bottom) {
                        // Controls
                        HStack(spacing: 20) {
                            // Stop Button
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    showStopConfirmation.toggle()
                                }
                            }) {
                                if showStopConfirmation {
                                    Text("Stop Working")
                                } else {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 20, weight: .bold))
                                }
                            }
                            .secondaryButtonStyle(color: .red, opacity: showStopConfirmation ? 0.3 : 0.1)
                            
                            // Pause/Continue Button
                            Button(action: viewModel.toggleTimer) {
                                if viewModel.isRunning {
                                    HStack(spacing: 8) {
                                        Image(systemName: "pause.fill")
                                            .font(.system(size: 20, weight: .bold))
                                    }
                                } else {
                                    HStack(spacing: 8) {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 20, weight: .bold))
                                        Text("Continue")
                                    }
                                }
                            }
                            .secondaryButtonStyle(opacity: viewModel.isRunning ? 0.1 : 0.3)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                    }
            }
        }
        .onAppear {
            viewModel.start() // Démarrer automatiquement le timer
        }
    }
}

#Preview {
    PomodoroView()
} 