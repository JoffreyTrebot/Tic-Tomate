import Foundation

class SettingsViewModel: ObservableObject {
    @Published private(set) var workDuration: Int
    @Published private(set) var shortBreakDuration: Int
    @Published private(set) var longBreakDuration: Int
    @Published private(set) var cyclesBeforeLongBreak: Int
    
    private let defaults = UserDefaults.standard
    private let haptics = HapticFeedbackService.shared
    
    init() {
        // Initialiser d'abord toutes les propriétés
        self.workDuration = defaults.integer(forKey: "workDuration")
        self.shortBreakDuration = defaults.integer(forKey: "shortBreakDuration")
        self.longBreakDuration = defaults.integer(forKey: "longBreakDuration")
        self.cyclesBeforeLongBreak = defaults.integer(forKey: "cyclesBeforeLongBreak")
        
        // Puis définir les valeurs par défaut si nécessaire
        if self.workDuration == 0 { self.workDuration = 25 }
        if self.shortBreakDuration == 0 { self.shortBreakDuration = 5 }
        if self.longBreakDuration == 0 { self.longBreakDuration = 15 }
        if self.cyclesBeforeLongBreak == 0 { self.cyclesBeforeLongBreak = 4 }
    }
    
    // Méthodes pour mettre à jour les valeurs
    func updateWorkDuration(_ value: Int) {
        workDuration = value
        defaults.set(value, forKey: "workDuration")
        updateTimerSettings()
        haptics.settingsChanged()
    }
    
    func updateShortBreakDuration(_ value: Int) {
        shortBreakDuration = value
        defaults.set(value, forKey: "shortBreakDuration")
        updateTimerSettings()
        haptics.settingsChanged()
    }
    
    func updateLongBreakDuration(_ value: Int) {
        longBreakDuration = value
        defaults.set(value, forKey: "longBreakDuration")
        updateTimerSettings()
        haptics.settingsChanged()
    }
    
    func updateCyclesBeforeLongBreak(_ value: Int) {
        cyclesBeforeLongBreak = value
        defaults.set(value, forKey: "cyclesBeforeLongBreak")
        updateTimerSettings()
        haptics.settingsChanged()
    }
    
    private func updateTimerSettings() {
        let settings = TimerSettings(
            workDuration: workDuration * 60,
            shortBreakDuration: shortBreakDuration * 60,
            longBreakDuration: longBreakDuration * 60,
            cyclesBeforeLongBreak: cyclesBeforeLongBreak
        )
        
        NotificationCenter.default.post(
            name: .timerSettingsDidChange,
            object: settings
        )
    }
}

extension Notification.Name {
    static let timerSettingsDidChange = Notification.Name("timerSettingsDidChange")
} 