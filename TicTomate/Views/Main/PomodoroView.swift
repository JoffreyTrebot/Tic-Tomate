import SwiftUI

struct PomodoroView: View {
    @StateObject private var viewModel = PomodoroViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showStopConfirmation = false
    @Environment(\.presentationMode) var presentationMode
    @Namespace private var buttonNamespace
    @State private var showContinueText = false
    
    private let padding: CGFloat = 16
    
    func toggleTimer() {
        if viewModel.isRunning {
            // Si on met en pause
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                viewModel.toggleTimer()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeOut(duration: 0.15)) {
                    showContinueText = true
                }
            }
        } else {
            // Si on reprend
            withAnimation(.easeOut(duration: 0.15)) {
                showContinueText = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    viewModel.toggleTimer()
                }
            }
        }
    }
    
    var pauseButton: some View {
        Button(action: toggleTimer) {
            HStack(spacing: 8) {
                if viewModel.isRunning {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 20, weight: .bold))
                        .transition(.opacity)
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 20, weight: .bold))
                            .transition(.opacity)
                        
                        if showContinueText {
                            Text("Continue")
                                .transition(.opacity)
                        }
                    }
                }
            }
        }
        .secondaryButtonStyle(opacity: viewModel.isRunning ? 0.1 : 0.3)
    }
    
    var mainContent: some View {
        VStack(spacing: 0) {
            // Timer
            FlipClockView(timeString: viewModel.timeRemainingText)
                .frame(maxHeight: .infinity, alignment: .center)
            
            // Bottom Controls Container
            HStack {
                // Stats
                VStack(alignment: .leading, spacing: 4) {
                    StatsRow(
                        icon: "clock.fill",
                        label: "Work time",
                        value: viewModel.formatStatsTime(viewModel.totalWorkTime)
                    )
                    StatsRow(
                        icon: "cup.and.saucer.fill",
                        label: "Break time",
                        value: viewModel.formatStatsTime(viewModel.totalBreakTime)
                    )
                }
                .font(.outfit(12, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
                
                Spacer()
                
                // Controls
                HStack(spacing: 20) {
                    if !showStopConfirmation {
                        // Stop Button
                        Button(action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                showStopConfirmation = true
                            }
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                        }
                        .secondaryButtonStyle(color: .red, opacity: 0.1)
                        .matchedGeometryEffect(id: "stopButton", in: buttonNamespace)
                    }
                    
                    // Pause/Continue Button
                    pauseButton
                    .allowsHitTesting(!showStopConfirmation)
                }
            }
            .padding(.horizontal, padding)
        }
        .padding(padding)
    }
    
    var body: some View {
        LandscapeView {
            ZStack {
                // Contenu principal
                VStack(spacing: 16) {
                    // Timer
                    FlipClockView(timeString: viewModel.timeRemainingText)
                    
                    // Bottom Controls Container
                    HStack {
                        // Stats
                        VStack(alignment: .leading, spacing: 4) {
                            StatsRow(
                                icon: "clock.fill",
                                label: "Work time",
                                value: viewModel.formatStatsTime(viewModel.totalWorkTime)
                            )
                            StatsRow(
                                icon: "cup.and.saucer.fill",
                                label: "Break time",
                                value: viewModel.formatStatsTime(viewModel.totalBreakTime)
                            )
                        }
                        .font(.outfit(12, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                        
                        Spacer()
                        
                        // Controls
                        HStack(spacing: 20) {
                            if !showStopConfirmation {
                                // Stop Button
                                Button(action: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        showStopConfirmation = true
                                    }
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 20, weight: .bold))
                                }
                                .secondaryButtonStyle(color: .red, opacity: 0.1)
                                .matchedGeometryEffect(id: "stopButton", in: buttonNamespace)
                            }
                            
                            // Pause/Continue Button
                            pauseButton
                            .allowsHitTesting(!showStopConfirmation)
                        }
                    }
                    .padding(.horizontal, 2)
                }
                .padding(.vertical, 16)
                .padding(padding)
                
                
                // Stop Working Overlay
                if showStopConfirmation {
                    StopWorkingOverlay(
                        onStop: {
                            viewModel.reset()
                            presentationMode.wrappedValue.dismiss()
                        },
                        onContinue: {
                            showStopConfirmation = false
                        },
                        namespace: buttonNamespace,
                        timeString: viewModel.timeRemainingText,
                        workTime: viewModel.formatStatsTime(viewModel.totalWorkTime),
                        breakTime: viewModel.formatStatsTime(viewModel.totalBreakTime),
                        isRunning: viewModel.isRunning
                    )
                }
            }
        }
        .onAppear {
            viewModel.start()
        }
    }
}

struct StatsRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 6) {
            Text(label)
            Text(value)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    PomodoroView()
} 
