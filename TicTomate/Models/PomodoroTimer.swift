import Foundation

enum PomodoroState {
    case idle
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimer: ObservableObject {
    @Published private(set) var timeRemaining: Int
    @Published private(set) var currentState: PomodoroState = .idle
    @Published private(set) var cycleCount: Int = 0
    
    private var settings: TimerSettings
    private var timer: Timer?
    
    init(settings: TimerSettings = .default) {
        self.settings = settings
        self.timeRemaining = settings.workDuration
    }
    
    func start() {
        guard timer == nil else { return }
        currentState = .work
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        pause()
        currentState = .idle
        cycleCount = 0
        timeRemaining = settings.workDuration
    }
    
    private func tick() {
        guard timeRemaining > 0 else {
            handleSessionComplete()
            return
        }
        timeRemaining -= 1
    }
    
    private func handleSessionComplete() {
        pause()
        switch currentState {
        case .work:
            cycleCount += 1
            if cycleCount >= settings.cyclesBeforeLongBreak {
                currentState = .longBreak
                timeRemaining = settings.longBreakDuration
                cycleCount = 0
            } else {
                currentState = .shortBreak
                timeRemaining = settings.shortBreakDuration
            }
        case .shortBreak, .longBreak:
            currentState = .work
            timeRemaining = settings.workDuration
        case .idle:
            break
        }
    }
    
    func updateSettings(_ newSettings: TimerSettings) {
        settings = newSettings
        if currentState == .idle {
            timeRemaining = settings.workDuration
        }
    }
} 