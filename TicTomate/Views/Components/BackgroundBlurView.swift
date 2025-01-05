import SwiftUI

struct BackgroundBlurView: View {
    let rootView: AnyView
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            // Fond noir semi-transparent
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            
            // Vue floutée
            HStack(spacing: 0) {
                // En mode landscape, on gère le safe area à gauche
                if horizontalSizeClass == .regular {
                    Color.clear
                        .frame(width: UIApplication.shared.connectedScenes
                            .compactMap { $0 as? UIWindowScene }
                            .first?
                            .windows
                            .first?.safeAreaInsets.left ?? 0)
                }
                
                rootView
                    .allowsHitTesting(false)
                    .blur(radius: 15)
            }
        }
    }
} 
