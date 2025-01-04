import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Namespace private var buttonNamespace
    let showSettings: () -> Void
    @Binding var showTimer: Bool
    @State private var showStartWorkingOverlay = false
    @State private var showCountdown = false

    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        let mainContent = VStack(spacing: 0) {
            // Header
            HStack {
                Text("Tic & Tomate")
                    .font(.outfit(17, weight: .bold))
                Spacer()
                Button(action: showSettings) {
                    Image(systemName: "gear")
                }
            }
            .padding()
            .background(Color(.systemBackground))
            
            // Main content
            VStack(spacing: 8) {
                StatsSection(stats: viewModel.stats)
                StreakSection(weeklyStreak: viewModel.stats.weeklyStreak)
                Spacer()
                
                if !showStartWorkingOverlay {
                    StartWorkingButton(
                        action: { 
                            haptics.impactOccurred()
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                showStartWorkingOverlay = true
                            }
                        },
                        namespace: buttonNamespace,
                        isOverlay: false
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .padding(.horizontal, 16)
        }
        
        ZStack {
            // Background color
            Color.black
                .ignoresSafeArea()
            
            // Contenu principal
            mainContent
                .zIndex(1)
                .opacity(showStartWorkingOverlay || showCountdown ? 0 : 1)
            
            // Overlay
            if showStartWorkingOverlay {
                StartWorkingOverlay(
                    onStart: {
                        withAnimation {
                            showStartWorkingOverlay = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showCountdown = true
                            }
                        }
                    },
                    onDismiss: {
                        showStartWorkingOverlay = false
                    },
                    namespace: buttonNamespace,
                    rootView: AnyView(mainContent),
                    onStartCountdown: {
                        showStartWorkingOverlay = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            showCountdown = true
                        }
                    }
                )
                .zIndex(2)
            }
            
            // Countdown
            if showCountdown {
                CountdownView {
                    showCountdown = false
                    showTimer = true
                }
                .zIndex(3)
                .transition(.opacity)
            }
        }
    }
}

struct StatsSection: View {
    let stats: WorkStats
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 16) {
               Text("\(stats.todayMinutes)")
                   .font(.outfit(72, weight: .bold))
               Text("minutes\ntoday")
                    .font(.outfit(20, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            
            HStack(spacing: 0) {
                StatItem(value: stats.weekMinutes, label: "this week")
                StatItem(value: stats.monthMinutes, label: "this month")
                StatItem(value: stats.bestMonthMinutes, label: "so far")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 0)
            .background(Color.white.opacity(0.05))
            
        }
        .background(Color(.white.opacity(0.05)))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
               .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }
}

struct StatItem: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(value)")
                .font(.outfit(25, weight: .bold))
                .foregroundColor(.secondary)
            Text(label)
                .font(.outfit(12))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
    }
}

struct StreakSection: View {
    let weeklyStreak: [Bool]
    let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack() {
               Text("this week")
                   .font(.outfit(24, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10) {
                ForEach(0..<7) { index in
                    VStack (spacing: 10) {
                        Circle()
                            .stroke(isToday(index) ? Color.white : Color.clear, lineWidth: 2)
                            .background(
                                Circle()
                                    .fill(weeklyStreak[index] ? Color.white : Color.white.opacity(0.1))
                            )
                            .frame(width: 30, height: 30)
                        
                        Text(weekDays[index])
                            .font(.outfit(12))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(Color(.white.opacity(0.05)))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
               .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }
    
    private func isToday(_ index: Int) -> Bool {
        let today = Calendar.current.component(.weekday, from: Date()) - 1
        return index == today
    }
} 
