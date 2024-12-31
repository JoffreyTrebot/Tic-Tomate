import UIKit

class HapticFeedbackService {
    static let shared = HapticFeedbackService()
    
    private let lightFeedback = UIImpactFeedbackGenerator(style: .light)
    private let mediumFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let heavyFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    private init() {
        // Préparer les générateurs
        lightFeedback.prepare()
        mediumFeedback.prepare()
        heavyFeedback.prepare()
    }
    
    func buttonTap() {
        lightFeedback.impactOccurred()
    }
    
    func timerStart() {
        mediumFeedback.impactOccurred()
    }
    
    func timerComplete() {
        heavyFeedback.impactOccurred()
    }
    
    func settingsChanged() {
        lightFeedback.impactOccurred(intensity: 0.7)
    }
} 