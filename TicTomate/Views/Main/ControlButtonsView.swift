import SwiftUI

struct ControlButtonsView: View {
    let isRunning: Bool
    let onReset: () -> Void
    let onToggle: () -> Void
    let onSettings: () -> Void
    
    var body: some View {
        HStack(spacing: 60) {
            Button(action: onReset) {
                Image(systemName: "arrow.counterclockwise")
                    .controlButtonStyle()
            }
            
            Button(action: onToggle) {
                Image(systemName: isRunning ? "pause.fill" : "play.fill")
                    .controlButtonStyle()
            }
            
            Button(action: onSettings) {
                Image(systemName: "gear")
                    .controlButtonStyle()
            }
        }
    }
}

struct ControlButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.primary)
            .frame(width: 44, height: 44)
            .background(Color(.systemGray6))
            .clipShape(Circle())
    }
}

extension View {
    func controlButtonStyle() -> some View {
        modifier(ControlButtonModifier())
    }
} 