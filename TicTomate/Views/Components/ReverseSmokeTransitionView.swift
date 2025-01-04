import SwiftUI

struct ReverseSmokeTransitionView: View {
    @State private var scale: CGFloat = 1.2
    @State private var opacity: Double = 1
    let onComplete: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Cercles de fumée qui se dissipent
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
                withAnimation(.easeInOut(duration: 0.6)) {
                    scale = 0.1
                    opacity = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onComplete()
                }
            }
        }
    }
} 