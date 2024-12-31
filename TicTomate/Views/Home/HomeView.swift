import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let showSettings: () -> Void
    @Binding var showTimer: Bool
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Tic & Tomate")
                    .font(.headline)
                Spacer()
                Button(action: showSettings) {
                    Image(systemName: "gear")
                }
            }
            .padding()
            .background(Color(.systemBackground))
            
            // Main content
            VStack(spacing: 20) {
                StatsSection(stats: viewModel.stats)
                
                StreakSection(weeklyStreak: viewModel.stats.weeklyStreak)
                
                Spacer()
                
                Button(action: { showTimer = true }) {
                    Text("Start Working")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

struct StatsSection: View {
    let stats: WorkStats
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(stats.todayMinutes)")
                .font(.system(size: 72, weight: .light))
            Text("minutes today")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 30) {
                StatItem(value: stats.weekMinutes, label: "this week")
                StatItem(value: stats.monthMinutes, label: "this month")
                StatItem(value: stats.bestMonthMinutes, label: "so far")
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct StatItem: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(value)")
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct StreakSection: View {
    let weeklyStreak: [Bool]
    let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("this week")
                .font(.title2)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                ForEach(0..<7) { index in
                    VStack {
                        Circle()
                            .stroke(isToday(index) ? Color.blue : Color.clear, lineWidth: 2)
                            .background(
                                Circle()
                                    .fill(weeklyStreak[index] ? Color.green : Color(.systemGray5))
                            )
                            .frame(width: 40, height: 40)
                        
                        Text(weekDays[index])
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    private func isToday(_ index: Int) -> Bool {
        let today = Calendar.current.component(.weekday, from: Date()) - 1
        return index == today
    }
} 