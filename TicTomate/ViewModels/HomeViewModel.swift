import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published private(set) var stats = WorkStats.empty
    private let cloudService = CloudStatsService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.publisher(for: .workStatsDidChange)
            .sink { [weak self] _ in
                self?.fetchStats()
            }
            .store(in: &cancellables)
        
        fetchStats()
    }
    
    private func fetchStats() {
        stats = cloudService.fetchStats()
    }
} 