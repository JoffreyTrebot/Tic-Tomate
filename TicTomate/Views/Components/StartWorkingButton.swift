import SwiftUI

struct StartWorkingButton: View {
    let action: () -> Void
    let namespace: Namespace.ID
    let isOverlay: Bool
    
    var body: some View {
        Button(action: action) {
            Text("Start Working")
                .font(.outfit(18, weight: .bold))
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .foregroundColor(isOverlay ? .black : .white)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill(isOverlay ? .white : Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                )
        }
        .matchedGeometryEffect(id: "startButton", in: namespace)
    }
}