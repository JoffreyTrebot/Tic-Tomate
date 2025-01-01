import SwiftUI

struct StartWorkingOverlay: View {
    let onStart: () -> Void
    let onDismiss: () -> Void
    let namespace: Namespace.ID
    let rootView: AnyView
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundBlurView(rootView: rootView)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            onDismiss()
                        }
                    }
                
                // Contenu
                VStack(spacing: 24) {
                    Text("Turn your iPhone,\nand then it's time to work")
                        .font(.outfit(24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .opacity(0.9)
                    
                    StartWorkingButton(
                        action: onStart,
                        namespace: namespace,
                        isOverlay: true
                    )
                }
                .padding(32)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity)
    }
} 