import Foundation
import CloudKit

struct WorkStats {
    var todayMinutes: Int
    var weekMinutes: Int
    var monthMinutes: Int
    var bestMonthMinutes: Int
    var weeklyStreak: [Bool] // [Dimanche, Lundi, ..., Samedi]
    var currentStreak: Int
    
    static let empty = WorkStats(
        todayMinutes: 0,
        weekMinutes: 0,
        monthMinutes: 0,
        bestMonthMinutes: 0,
        weeklyStreak: Array(repeating: false, count: 7),
        currentStreak: 0
    )
} 
