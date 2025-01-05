import Foundation
import Combine

class PomodoroViewModel: ObservableObject {
    @Published private(set) var timeRemainingText: String = "25:00"
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var totalWorkTime: Int = 0
    @Published private(set) var totalBreakTime: Int = 0
    @Published var showSettings: Bool = false
    
    private let timer: PomodoroTimer
    private var cancellables = Set<AnyCancellable>()
    private let haptics = HapticFeedbackService.shared
    private var statsTimer: Timer?
    
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
        
        timer.$currentState
            .sink { [weak self] state in
                if state == .work {
                    self?.startStatsTimer { self?.totalWorkTime += 1 }
                } else if state == .shortBreak || state == .longBreak {
                    self?.startStatsTimer { self?.totalBreakTime += 1 }
                } else {
                    self?.stopStatsTimer()
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
    
    private func startStatsTimer(update: @escaping () -> Void) {
        stopStatsTimer()
        statsTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            update()
        }
    }
    
    private func stopStatsTimer() {
        statsTimer?.invalidate()
        statsTimer = nil
    }
    
    func formatStatsTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        if hours > 0 {
            return String(format: "%dh %02dm", hours, minutes)
        } else {
            return String(format: "%dm", minutes)
        }
    }
} 