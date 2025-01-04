import Foundation
import Combine

class PomodoroViewModel: ObservableObject {
    @Published private(set) var timeRemainingText: String = "25:00"
    @Published private(set) var isRunning: Bool = false
    @Published var showSettings: Bool = false
    
    private let timer: PomodoroTimer
    private var cancellables = Set<AnyCancellable>()
    private let haptics = HapticFeedbackService.shared
    
    init(timer: PomodoroTimer = PomodoroTimer()) {
        self.timer = timer
        
        timer.$timeRemaining
            .map { self.formatTime($0) }
            .assign(to: &$timeRemainingText)
        
        NotificationCenter.default
            .publisher(for: .timerSettingsDidChange)
            .compactMap { $0.object as? TimerSettings }
            .sink { [weak self] settings in
                self?.timer.updateSettings(settings)
                self?.haptics.settingsChanged()
            }
            .store(in: &cancellables)
        
        timer.$currentState
            .dropFirst()
            .sink { [weak self] state in
                if state != .idle {
                    self?.haptics.timerComplete()
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleTimer() {
        isRunning.toggle()
        if isRunning {
            timer.start()
            haptics.timerStart()
        } else {
            timer.pause()
            haptics.buttonTap()
        }
    }
    
    func reset() {
        isRunning = false
        timer.reset()
        haptics.buttonTap()
    }
    
    func openSettings() {
        showSettings = true
        haptics.buttonTap()
    }
    
    func start() {
        isRunning = true
        timer.start()
        haptics.timerStart()
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
} 