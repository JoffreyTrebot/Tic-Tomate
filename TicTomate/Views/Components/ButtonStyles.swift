import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.outfit(18, weight: .bold))
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .foregroundColor(.black)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(.white)
            )
    }
}

struct SecondaryButtonStyle: ViewModifier {
    var color: Color = .white
    var opacity: Double = 0.1
    
    func body(content: Content) -> some View {
        content
            .font(.outfit(18, weight: .bold))
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .foregroundColor(color)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(color.opacity(opacity))
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(color.opacity(0.1), lineWidth: 1)
                    )
            )
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        modifier(PrimaryButtonStyle())
    }
    
    func secondaryButtonStyle(color: Color = .white, opacity: Double = 0.1) -> some View {
        modifier(SecondaryButtonStyle(color: color, opacity: opacity))
    }
} 