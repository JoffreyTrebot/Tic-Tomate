import SwiftUI

struct CountdownView: View {
    let onComplete: () -> Void
    @State private var currentNumber = 3
    @State private var opacity = 1.0
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if currentNumber > 0 {
                Text("\(currentNumber)")
                    .font(.system(size: 120, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .scaleEffect(scale)
                    .onAppear {
                        startCountdown()
                    }
            }
        }
    }
    
    private func startCountdown() {
        withAnimation(.easeInOut(duration: 0.8)) {
            opacity = 0
            scale = 2.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            if currentNumber > 1 {
                currentNumber -= 1
                opacity = 1
                scale = 1
                startCountdown()
            } else {
                onComplete()
            }
        }
    }
} 