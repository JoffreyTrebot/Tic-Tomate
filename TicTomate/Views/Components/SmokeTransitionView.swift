import SwiftUI

struct SmokeTransitionView: View {
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 0
    let onComplete: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Plusieurs cercles avec des opacités et échelles différentes pour créer l'effet de fumée
                ForEach(0..<5) { index in
                    Circle()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 2, height: geometry.size.width * 2)
                        .offset(y: -geometry.size.width / 4)
                        .scaleEffect(scale)
                        .opacity(opacity * (1 - Double(index) * 0.15))
                        .blur(radius: CGFloat(index * 20))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    scale = 1.2
                    opacity = 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    onComplete()
                }
            }
        }
    }
} 