import SwiftUI

enum AppScreen {
    case home
    case settings
}

class NavigationState: ObservableObject {
    @Published var currentScreen: AppScreen = .home
} 