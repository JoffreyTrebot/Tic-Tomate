import SwiftUI

struct BackgroundBlurView: View {
    let rootView: AnyView
    
    var body: some View {
        ZStack {
            // Fond noir semi-transparent
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            // Vue floutée
            VStack(spacing: 0) {
                Color.clear
                    .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                
                rootView
                    .allowsHitTesting(false)
                    .blur(radius: 20)
            }
        }
    }
} 