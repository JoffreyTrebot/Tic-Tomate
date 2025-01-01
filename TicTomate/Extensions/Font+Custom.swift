import SwiftUI

extension Font {
    static func outfit(_ size: CGFloat, weight: Weight = .regular) -> Font {
        return .custom("Outfit", size: size, relativeTo: .body)
            .weight(weight)
    }
}

// Exemples d'utilisation :
// .font(.outfit(16, weight: .bold))
// .font(.outfit(72, weight: .light))
// .font(.outfit(24))