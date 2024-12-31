import Foundation

struct TimerSettings {
    var workDuration: Int
    var shortBreakDuration: Int
    var longBreakDuration: Int
    var cyclesBeforeLongBreak: Int
    
    static let `default` = TimerSettings(
        workDuration: 25 * 60,
        shortBreakDuration: 5 * 60,
        longBreakDuration: 15 * 60,
        cyclesBeforeLongBreak: 4
    )
} 