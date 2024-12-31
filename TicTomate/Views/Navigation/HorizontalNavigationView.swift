import SwiftUI

struct HorizontalNavigationView<Content: View>: View {
    @Binding var currentScreen: AppScreen
    let content: Content
    
    init(currentScreen: Binding<AppScreen>, @ViewBuilder content: () -> Content) {
        self._currentScreen = currentScreen
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                content
            }
            .offset(x: offsetForScreen(width: geometry.size.width))
            .animation(.easeInOut(duration: 0.3), value: currentScreen)
        }
    }
    
    private func offsetForScreen(width: CGFloat) -> CGFloat {
        switch currentScreen {
        case .home:
            return 0
        case .settings:
            return -width
        }
    }
} 