import SwiftUI

struct StartWorkingOverlay: View {
    let onStart: () -> Void
    let onDismiss: () -> Void
    let namespace: Namespace.ID
    let rootView: AnyView
    let onStartCountdown: () -> Void
    
    private let lottieURL = "https://lottie.host/aa3b6ae9-1f8b-4420-a167-c4f990770a5b/cMCSDGu08Y.json";
    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                BackgroundBlurView(rootView: rootView)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            onDismiss()
                        }
                    }
                
                // Contenu centré
                VStack(spacing: 24) {
                    // Animation Lottie
                    LottieView(
                        url: lottieURL,
                        size: CGSize(width: 80, height: 80),
                        color: .white
                    )
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    
                    Text("Turn your iPhone,\nand then it's time to work")
                        .font(.outfit(24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .opacity(0.9)
                    
                    StartWorkingButton(
                        action: {
                            haptics.impactOccurred()
                            withAnimation {
                                onDismiss()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    onStartCountdown()
                                }
                            }
                        },
                        namespace: namespace,
                        isOverlay: true
                    )
                }
                .padding(32)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity)
    }
} 
