import SwiftUI

struct CountdownView: View {
    let onComplete: () -> Void
    @State private var currentNumber = 3
    @State private var nextNumber = 2
    @State private var isAnimating = false
    @State private var showNextNumber = false
    @State private var showReverseSmoke = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if !showReverseSmoke {
                if currentNumber > 0 {
                    ZStack {
                        // Numéro actuel
                        Text("\(currentNumber)")
                            .font(.system(size: 200, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .opacity(isAnimating ? 0 : 1)
                            .scaleEffect(isAnimating ? 1.5 : 1)
                            .blur(radius: isAnimating ? 20 : 0)
                        
                        // Prochain numéro
                        if showNextNumber && nextNumber > 0 {
                            Text("\(nextNumber)")
                                .font(.system(size: 200, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .opacity(isAnimating ? 1 : 0)
                                .scaleEffect(isAnimating ? 1 : 0.5)
                                .blur(radius: isAnimating ? 0 : 20)
                        }
                    }
                    .onAppear {
                        startCountdown()
                    }
                }
            } else {
                // Effet de fumée inverse
                ReverseSmokeTransitionView {
                    onComplete()
                }
            }
        }
    }
    
    private func startCountdown() {
        guard currentNumber > 1 else {
            withAnimation(.easeInOut(duration: 0.8)) {
                isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showReverseSmoke = true
            }
            return
        }
        
        // Préparer le prochain numéro
        nextNumber = currentNumber - 1
        
        // Animation de sortie du numéro actuel
        withAnimation(.easeInOut(duration: 0.4)) {
            showNextNumber = true
        }
        
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            isAnimating = true
        }
        
        // Transition vers le prochain numéro
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            currentNumber -= 1
            isAnimating = false
            showNextNumber = false
            
            // Continuer le compte à rebours
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startCountdown()
            }
        }
    }
}

#Preview {
    CountdownView(onComplete: {})
} 