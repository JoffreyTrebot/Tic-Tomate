import SwiftUI

struct StopWorkingOverlay: View {
    let onStop: () -> Void
    let onContinue: () -> Void
    let namespace: Namespace.ID
    let timeString: String
    let workTime: String
    let breakTime: String
    let isRunning: Bool
    
    @State private var showContinueText = false
    
    var body: some View {
        ZStack {
            // Background blur avec fond noir semi-transparent
            BackgroundBlurView(rootView: AnyView(
                VStack(spacing: 0) {
                    // Timer
                    FlipClockView(timeString: timeString)
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                    // Bottom Controls Container
                    HStack {
                        // Stats
                        VStack(alignment: .leading, spacing: 8) {
                            StatsRow(
                                icon: "clock.fill",
                                label: "Work time",
                                value: workTime
                            )
                            StatsRow(
                                icon: "cup.and.saucer.fill",
                                label: "Break time",
                                value: breakTime
                            )
                        }
                        .font(.outfit(12, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                        
                        Spacer()
                        
                        // Pause Button
                        Button(action: {
                            if isRunning {
                                withAnimation(.easeOut(duration: 0.15)) {
                                    showContinueText = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    // Action factice car c'est juste pour l'affichage
                                }
                            }
                        }) {
                            HStack(spacing: 8) {
                                if isRunning {
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
                        .secondaryButtonStyle(opacity: isRunning ? 0.1 : 0.3)
                        .animation(.easeOut(duration: 0.2), value: isRunning)
                    }
                }
                .padding(40)
            ))
            .background(Color.black.opacity(0.8))
            
            // Boutons
            VStack(spacing: 16) {
                Button(action: {
                    withAnimation {
                        onStop()
                    }
                }) {
                    Text("Stop Working")
                        .matchedGeometryEffect(id: "stopButton", in: namespace)
                }
                .secondaryButtonStyle(color: .red, opacity: 0.3)
                
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        onContinue()
                    }
                }) {
                    Text("Continue")
                }
                .secondaryButtonStyle()
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                onContinue()
            }
        }
        .onAppear {
            showContinueText = !isRunning
        }
    }
} 