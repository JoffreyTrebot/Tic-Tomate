import Foundation

class CloudStatsService {
    static let shared = CloudStatsService()
    private let defaults = UserDefaults.standard
    
    private init() {
        // Initialiser avec des données de démo si c'est la première fois
        if !defaults.bool(forKey: "demo_data_initialized") {
            initializeDemoData()
        }
    }
    
    private func initializeDemoData() {
        // Données du jour
        defaults.set(125, forKey: "today_minutes") // 2h05 de travail aujourd'hui
        
        // Données de la semaine (total: 8h45)
        defaults.set(525, forKey: "week_minutes")
        
        // Données du mois (total: 35h20)
        defaults.set(2120, forKey: "month_minutes")
        
        // Meilleur mois (42h15)
        defaults.set(2535, forKey: "best_month_minutes")
        
        // Streak hebdomadaire (5 jours sur 7)
        var weekStreak = [true, true, true, true, true, false, false]
        defaults.set(weekStreak, forKey: "weekly_streak")
        
        // Streak actuel
        defaults.set(5, forKey: "current_streak")
        
        // Marquer que les données de démo ont été initialisées
        defaults.set(true, forKey: "demo_data_initialized")
    }
    
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
        let todayMinutes = defaults.integer(forKey: "today_minutes")
        let weekMinutes = defaults.integer(forKey: "week_minutes")
        let monthMinutes = defaults.integer(forKey: "month_minutes")
        let bestMonthMinutes = defaults.integer(forKey: "best_month_minutes")
        let weeklyStreak = defaults.array(forKey: "weekly_streak") as? [Bool] ?? Array(repeating: false, count: 7)
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