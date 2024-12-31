import Foundation

class CloudStatsService {
    static let shared = CloudStatsService()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func saveWorkSession(minutes: Int) {
        let today = Calendar.current.startOfDay(for: Date())
        
        // Sauvegarder les minutes du jour
        var todayMinutes = defaults.integer(forKey: "today_minutes")
        todayMinutes += minutes
        defaults.set(todayMinutes, forKey: "today_minutes")
        
        // Sauvegarder la date de la dernière session
        defaults.set(today, forKey: "last_session_date")
        
        // Mettre à jour le streak
        updateStreak()
        
        NotificationCenter.default.post(name: .workStatsDidChange, object: nil)
    }
    
    func fetchStats() -> WorkStats {
        let today = Calendar.current.startOfDay(for: Date())
        let todayMinutes = defaults.integer(forKey: "today_minutes")
        let weekMinutes = calculateWeekMinutes()
        let monthMinutes = calculateMonthMinutes()
        let bestMonthMinutes = defaults.integer(forKey: "best_month_minutes")
        let weeklyStreak = getWeeklyStreak()
        let currentStreak = defaults.integer(forKey: "current_streak")
        
        return WorkStats(
            todayMinutes: todayMinutes,
            weekMinutes: weekMinutes,
            monthMinutes: monthMinutes,
            bestMonthMinutes: bestMonthMinutes,
            weeklyStreak: weeklyStreak,
            currentStreak: currentStreak
        )
    }
    
    private func calculateWeekMinutes() -> Int {
        // Pour l'instant, retournons juste les minutes du jour
        return defaults.integer(forKey: "today_minutes")
    }
    
    private func calculateMonthMinutes() -> Int {
        // Pour l'instant, retournons juste les minutes du jour
        return defaults.integer(forKey: "today_minutes")
    }
    
    private func getWeeklyStreak() -> [Bool] {
        var streak = Array(repeating: false, count: 7)
        let today = Calendar.current.component(.weekday, from: Date()) - 1
        streak[today] = defaults.integer(forKey: "today_minutes") > 0
        return streak
    }
    
    private func updateStreak() {
        var currentStreak = defaults.integer(forKey: "current_streak")
        let lastSessionDate = defaults.object(forKey: "last_session_date") as? Date ?? Date()
        
        if Calendar.current.isDateInToday(lastSessionDate) {
            currentStreak += 1
            defaults.set(currentStreak, forKey: "current_streak")
        }
    }
}

extension Notification.Name {
    static let workStatsDidChange = Notification.Name("workStatsDidChange")
} 