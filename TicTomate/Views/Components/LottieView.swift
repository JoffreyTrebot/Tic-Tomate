import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let url: String
    let size: CGSize
    let color: Color?
    
    init(url: String, size: CGSize, color: Color? = nil) {
        self.url = url
        self.size = size
        self.color = color
    }
    
    func makeUIView(context: Context) -> UIView {
        let containerView = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        
        // Configuration du conteneur
        containerView.frame = CGRect(origin: .zero, size: size)
        containerView.backgroundColor = .clear
        
        // Configuration de l'animation
        animationView.frame = containerView.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        
        // Charger l'animation depuis l'URL
        if let url = URL(string: url) {
            LottieAnimation.loadedFrom(url: url) { animation in
                animationView.animation = animation
                animationView.loopMode = .loop
                
                // Appliquer la couleur si spécifiée
                if let color = color {
                    let colorProvider = ColorValueProvider(UIColor(color).lottieColorValue)
                    let keypath = AnimationKeypath(keypath: "**.Fill 1.Color")
                    animationView.setValueProvider(colorProvider, keypath: keypath)
                }
                
                animationView.play()
            }
        }
        
        containerView.addSubview(animationView)
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.frame = CGRect(origin: .zero, size: size)
        if let animationView = uiView.subviews.first as? LottieAnimationView {
            animationView.frame = uiView.bounds
        }
    }
}

// Extension pour le modifier conditionnel
extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
} 